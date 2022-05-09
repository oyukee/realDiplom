import 'dart:convert';
import '../utils/Func.dart';

class OrderListResponse {
  final List<OrderModel> list;

  OrderListResponse({
    required this.list,
  });

  factory OrderListResponse.fromJson(List<dynamic> parsedJson) {
    List<OrderModel> list;//= new List<UserResponse>();
    list = parsedJson.map((i) => OrderModel.fromJson(i)).toList();

    return new OrderListResponse(list: list);
  }
}
class OrderModel {
  int? orderPersonID;
  String? userId;
  int? productID;
  double? discount;
  int? quantity;
  double? grandTotal;
  String? productTitle;
  String? summary;
  String? statusName;
  String? imageUrl;
  int? currentOrderQty;
  int? groupQty;

  OrderModel(
      {this.orderPersonID,
        this.userId,
        this.productID,
        this.discount,
        this.quantity,
        this.grandTotal,
        this.productTitle,
        this.summary,
        this.statusName,
        this.imageUrl,
        this.currentOrderQty,
        this.groupQty});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderPersonID = Func.toInt(json['Order_person_ID']);
    userId = json['user_id'];
    productID = Func.toInt(json['ProductID']);
    discount = Func.toDouble(json['discount']);
    quantity = Func.toInt(json['quantity']);
    grandTotal = Func.toDouble(json['grandTotal']);
    productTitle = json['product_title'];
    summary = json['summary'];
    statusName = json['statusname'];
    imageUrl = json['image_url'];
    currentOrderQty = Func.toInt(json['current_order_qty']);
    groupQty = Func.toInt(json['group_qty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Order_person_ID'] = this.orderPersonID;
    data['user_id'] = this.userId;
    data['ProductID'] = this.productID;
    data['discount'] = this.discount;
    data['quantity'] = this.quantity;
    data['grandTotal'] = this.grandTotal;
    data['product_title'] = this.productTitle;
    data['summary'] = this.summary;
    data['statusName'] = this.statusName;
    data['image_url'] = this.imageUrl;
    data['current_order_qty'] = this.currentOrderQty;
    data['group_qty'] = this.groupQty;
    return data;
  }
}

