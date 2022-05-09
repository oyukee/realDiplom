import 'dart:convert';
import '../utils/Func.dart';

class ProdGroupResponse {
  final List<ProdGroupModel> list;

  ProdGroupResponse({
    required this.list,
  });

  factory ProdGroupResponse.fromJson(List<dynamic> parsedJson) {
    List<ProdGroupModel> list;
    list = parsedJson.map((i) => ProdGroupModel.fromJson(i)).toList();

    return new ProdGroupResponse(list: list);
  }
}

class ProdGroupModel {
  String? orderGroupID;
  int? productID;
  int? orderQuantity;

  ProdGroupModel({this.orderGroupID, this.productID, this.orderQuantity});

  ProdGroupModel.fromJson(Map<String, dynamic> json) {
    orderGroupID = json['order_group_ID'];
    productID = json['ProductID'];
    orderQuantity = json['order_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_group_ID'] = this.orderGroupID;
    data['ProductID'] = this.productID;
    data['order_quantity'] = this.orderQuantity;
    return data;
  }
}
