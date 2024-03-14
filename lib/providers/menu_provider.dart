import 'dart:convert';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:justitis_app/models.dart';
import 'package:justitis_app/services/appwrite_service.dart';

enum IngredientCategory {
  panino,
  farcitura,
  aggiunte,
  snack,
  bevande,
  prodottoDelGiorno,
  pns
}

class MenuProvider extends ChangeNotifier {
  List<Ingredient> _ingredients = [];
  final List<Order> _cart = [];

  List<Order> get cart => _cart;
  List<Ingredient> get ingredients => _ingredients;

  List<Ingredient> _availableFillings = [];
  List<Ingredient> _availableAdditions = [];

  List<Ingredient> get availableFillings => _availableFillings;
  List<Ingredient> get availableAdditions => _availableAdditions;

  final List<Ingredient> _orderFillings = [];
  final List<Ingredient> _orderAdditions = [];

  List<Ingredient> get orderFillings => _orderFillings;
  List<Ingredient> get orderAdditions => _orderAdditions;

  bool onTime = false;

  bool _isOrderCreated = false;
  bool get isOrderCreated => _isOrderCreated;

  bool _waitToSendOrder = false;
  bool get waitToSendOrder => _waitToSendOrder;

  // Add Order to cart
  addOrder(Ingredient mainProduct,
      {List<Ingredient> fillings = const [],
      List<Ingredient> additions = const []}) {
    try {
      if (_cart.length + 1 > 15) return;
      int groupId = (_cart.isEmpty) ? 0 : _cart.length - 1;
      _cart.add(Order(
          groupId: groupId,
          mainProduct: mainProduct,
          fillings: fillings,
          additions: additions));
    } finally {
      notifyListeners();
    }
  }

  deleteOrder(int index) {
    _cart.removeAt(index);
    notifyListeners();
  }

  checkIfOnTime() async {
    try {
      bool startTime = (DateTime.now().hour >= 7 && DateTime.now().minute > 30);
      bool endTime = (DateTime.now().hour <= 9 && DateTime.now().minute <= 30);
      if (startTime && endTime) {
        onTime = true;
      } else {
        onTime = false;
      }
      onTime = true;
    } finally {
      notifyListeners();
    }
  }

  updateIngredients(List<IngredientCategory> categories) async {
    try {
      final ingredients = await AppwriteService.database.listDocuments(
          databaseId: 'justitisdb',
          collectionId: 'ingredients',
          queries: [Query.limit(1000)]);

      _ingredients = [];
      _availableAdditions = [];
      _availableFillings = [];
      _ingredients = ingredients.documents
          .map((e) => Ingredient.fromJson(e.data))
          .where((element) => categories.contains(
              IngredientCategory.values[element.productType.idProductType]))
          .toList();
      _availableFillings = ingredients.documents
          .map((e) => Ingredient.fromJson(e.data))
          .where((element) =>
              IngredientCategory.farcitura.index ==
              element.productType.idProductType)
          .toList();
      _availableAdditions = ingredients.documents
          .map((e) => Ingredient.fromJson(e.data))
          .where((element) =>
              IngredientCategory.aggiunte.index ==
              element.productType.idProductType)
          .toList();
    } finally {
      notifyListeners();
    }
  }

  clearIngredients() async {
    try {
      _ingredients = [];
      _availableAdditions = [];
      _availableFillings = [];
    } finally {
      notifyListeners();
    }
  }

  void sendOrderProgress(bool status) {
    _waitToSendOrder = status;
    notifyListeners();
  }

  // Create and send the order to Appwrite server
  createOrder() async {
    try {
      //if(!onTime) return;
      final userId = (await AppwriteService.account.get()).$id;
      final userdb = await AppwriteService.database.getDocument(
          databaseId: AppwriteService.databaseId,
          collectionId: 'users',
          documentId: userId);
      final jsonOrderData = jsonEncode(_cart);
      final jsonData = jsonEncode({
        'userId': userId,
        'order': jsonOrderData,
        'class': userdb.data['class']
      });
      if (userdb.data['class'] != null) {
        await AppwriteService.functions.createExecution(
            functionId: '65845986905c0ee440c2', data: jsonData);
        _isOrderCreated = true;
        _cart.clear();
      }
      _waitToSendOrder = false;
    } finally {
      notifyListeners();
    }
  }
}
