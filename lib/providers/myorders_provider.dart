import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:justitis_app/models.dart';
import 'package:justitis_app/providers/menu_provider.dart';
import 'package:justitis_app/services/appwrite_service.dart';

class MyOrdersProvider extends ChangeNotifier{
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<Document> getDetailedOrder(String id) async{
    final detailedOrder = await AppwriteService.database.getDocument(databaseId: AppwriteService.databaseId, collectionId: 'detailed-orders', documentId: id);
    return detailedOrder;
  }

  void updateOrdersList() async{
    try{
      var count = 0;
      final user = await AppwriteService.account.get();
      final summariesResult = await AppwriteService.database.listDocuments(databaseId: AppwriteService.databaseId, collectionId: 'order-summaries', queries: [Query.equal('user', user.$id)]);
      _orders.clear();
      for(var doc in summariesResult.documents){
        /*
          Manage detailed ordera with the condition if an complete order is single or composite meaning that 
          a complete order can contain single or multiple detailed orders
        */
        if(doc.data['completedOrder']['detailedOrders'].length > 1){
          final mainProduct = Ingredient.fromJson((await getDetailedOrder(doc.data['completedOrder']['detailedOrders'][0]['\$id'])).data['ingredient']);
          final idGroup = doc.data['completedOrder']['detailedOrders'][0]['idGroup'];
          final List<Ingredient> fillings = [];
          final List<Ingredient> additions = [];
          for(int i = 1; i < doc.data['completedOrder']['detailedOrders'].length; i++){
            final detailedOrder = await getDetailedOrder(doc.data['completedOrder']['detailedOrders'][i]['\$id']);
            final ingredient = Ingredient.fromJson(detailedOrder.data['ingredient']);
            if(IngredientCategory.farcitura.index == ingredient.productType.idProductType){
              fillings.add(ingredient);
            }else if(IngredientCategory.aggiunte.index == ingredient.productType.idProductType){
              additions.add(ingredient);
            }
          }
          _orders.add(Order(
              groupId: idGroup,
              mainProduct: mainProduct,
              fillings: fillings,
              additions: additions
          ));
        }else{
          final mainProduct = Ingredient.fromJson((await getDetailedOrder(doc.data['completedOrder']['detailedOrders'][0]['\$id'])).data['ingredient']);
          final idGroup = doc.data['completedOrder']['detailedOrders'][0]['idGroup'];
          _orders.add(Order(
            groupId: idGroup,
            mainProduct: mainProduct,
            fillings: [],
            additions: []
          ));
        }
        count += 1;
      }
    }finally{
      //print(orders);
      notifyListeners();
    }
  }

}