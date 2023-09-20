import 'dart:convert';

class ProductType{
  final String id;
  final String name;
  final int idProductType;

  ProductType({
    required this.id,
    required this.name,
    required this.idProductType
  });

  factory ProductType.fromJson(Map json){
    return ProductType(id: json['\$id'], name: json['name'], idProductType: json['idProductType']);
  }
}

class Ingredient{
  final String id;
  final String name;
  final String imageUrl;
  final ProductType productType;
  final double price;

  Ingredient({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.productType,
    required this.price
  });

  factory Ingredient.fromJson(Map json){
    return Ingredient(
      id: json['\$id'],
      name: json['name'],
      imageUrl: (json['imageUrl'] != null)?json['imageUrl']:'',
      productType: ProductType.fromJson(json['productType']),
      price: json['price']);
  }
}

class Order{
  final int groupId;
  final Ingredient mainProduct;
  final List<Ingredient> fillings;
  final List<Ingredient> additions;

  Order({
    required this.groupId,
    required this.mainProduct,
    required this.fillings,
    required this.additions
  });

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      groupId: json['idGroup'], 
      mainProduct: Ingredient.fromJson(jsonDecode(json['mainProduct'])), 
      fillings: jsonDecode(json['fillings']), 
      additions: jsonDecode(json['additions']));
  }

  Map<String, dynamic> toJson() => {
    'groupId': groupId,
    'mainProduct': mainProduct.id,
    'fillings': (fillings.isNotEmpty)?fillings.map((e) => e.id).toList():[],
    'additions': (additions.isNotEmpty)?additions.map((e) => e.id).toList():[]
  };
}

enum OrderStatus{
  scheduled, preparing, readytotake, delivering, delivered, completed
}

class SummarizedOrder{
  final String id;
  final List<Order> orders;
  final double totalPrice;
  final OrderStatus status;

  SummarizedOrder({
    required this.id,
    required this.orders,
    required this.totalPrice,
    required this.status
  });
}