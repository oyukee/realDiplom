import 'dart:convert';

import '../utils/Func.dart';

class ProductListResponse {
  final List<ProductModel> list;

  ProductListResponse({
    required this.list,
  });

  factory ProductListResponse.fromJson(List<dynamic> parsedJson) {
    List<ProductModel> list;//= new List<UserResponse>();
    list = parsedJson.map((i) => ProductModel.fromJson(i)).toList();

    return new ProductListResponse(list: list);
  }
}
class ProductModel {
  int? productID;
  String? userID;
  String? prodcutTitle;
  String? metaTitle;
  String? summary;
  double? productPrice;
  double? discount;
  int? quantity;
  int? groupQty;
  int? currentOrderQty;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? publishedAt;
  DateTime? startsAt;
  DateTime? endsAt;
  String? content;
  String? serialNo;
  String? imageUrl;
  bool isFavourite = true;
  double rating = 4.5;
  int? categoryID;

  ProductModel(
      {this.productID,
        this.categoryID,
        this.userID,
        this.prodcutTitle,
        this.metaTitle,
        this.summary,
        this.productPrice,
        this.discount,
        this.quantity,
        this.groupQty,
        this.currentOrderQty,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.publishedAt,
        this.startsAt,
        this.endsAt,
        this.content,
        this.serialNo,
        this.imageUrl});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productID =  Func.toInt(json['ProductID']);
    categoryID =  Func.toInt(json['CategoryID']==null?10:json['CategoryID']);
    userID = json['User_ID'];
    prodcutTitle = json['prodcut_title'];
    metaTitle = json['metaTitle'];
    summary = json['summary'];
    productPrice = Func.toDouble(json['product_price']);
    discount = Func.toDouble(json['discount']);
    quantity = Func.toInt(json['quantity']);
    groupQty = Func.toInt(json['group_qty']);
    currentOrderQty = Func.toInt(json['current_order_qty']);
    status = Func.toInt(json['status']);
    createdAt = Func.toDate(json['createdAt']==null?'': json['createdAt']);
    updatedAt = Func.toDate(json['updatedAt']==null?'': json['updatedAt']);
    publishedAt = Func.toDate(json['publishedAt']==null?'': json['publishedAt']);
    startsAt = Func.toDate(json['startsAt']==null?'': json['startsAt']);
    endsAt = Func.toDate(json['endsAt']==null?'': json['endsAt']);
    content = json['content'];
    serialNo = json['serial_no'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductID'] = this.productID;
    data['CategoryID'] = this.categoryID;
    data['User_ID'] = this.userID;
    data['prodcut_title'] = this.prodcutTitle;
    data['metaTitle'] = this.metaTitle;
    data['summary'] = this.summary;
    data['product_price'] = this.productPrice;
    data['discount'] = this.discount;
    data['quantity'] = this.quantity;
    data['group_qty'] = this.groupQty;
    data['current_order_qty'] = this.currentOrderQty;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    data['startsAt'] = this.startsAt;
    data['endsAt'] = this.endsAt;
    data['content'] = this.content;
    data['serial_no'] = this.serialNo;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
