import 'dart:convert';

import '../utils/Func.dart';

class CartItemListResponse {
  final List<CartItemModel> list;

  CartItemListResponse({
    required this.list,
  });

  factory CartItemListResponse.fromJson(List<dynamic> parsedJson) {
    List<CartItemModel> list;//= new List<UserResponse>();
    list = parsedJson.map((i) => CartItemModel.fromJson(i)).toList();

    return new CartItemListResponse(list: list);
  }
}

class CartItemModel {
  String? iD;
  int? productID;
  int? cartID;
  String? sku;
  int? price;
  int? discount;
  int? quantity;
  int? active;
  String? createdAt;
  String? updatedAt;
  String? content;
  String? imageUrl;

  CartItemModel(
      {this.iD,
        this.productID,
        this.cartID,
        this.sku,
        this.price,
        this.discount,
        this.quantity,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.content,
        this.imageUrl});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    productID = json['ProductID'];
    cartID = json['Cart_ID'];
    sku = json['sku'];
    price = json['price'];
    discount = json['discount'];
    quantity = json['quantity'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    content = json['content'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ProductID'] = this.productID;
    data['Cart_ID'] = this.cartID;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['quantity'] = this.quantity;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['content'] = this.content;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
