import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:justitis_app/models.dart';
import 'package:justitis_app/services/appwrite_service.dart';

class MyOrdersProvider extends ChangeNotifier{
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  void updateOrdersList() async{
    final user = await AppwriteService.account.get();
    final summariesResult = await AppwriteService.database.listDocuments(databaseId: AppwriteService.databaseId, collectionId: 'order-summaries', queries: [Query.equal('user', user.$id)]);
    for(var doc in summariesResult.documents){
      for(var detailedOrder in doc.data['completedOrder']['detailedOrders']){
        final rawDetailedOrder = await AppwriteService.database.getDocument(databaseId: AppwriteService.databaseId, collectionId: 'detailed-orders', documentId: detailedOrder['\$id']);
        print(rawDetailedOrder.data);
        _orders.add(Order.fromJson(rawDetailedOrder.data));
      }
    }
  }

}