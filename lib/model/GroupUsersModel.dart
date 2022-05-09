import 'dart:convert';
import '../utils/Func.dart';

class GroupUsersResponse {
  final List<GroupUsersModel> list;

  GroupUsersResponse({
    required this.list,
  });

  factory GroupUsersResponse.fromJson(List<dynamic> parsedJson) {
    List<GroupUsersModel> list;
    list = parsedJson.map((i) => GroupUsersModel.fromJson(i)).toList();

    return new GroupUsersResponse(list: list);
  }
}
class GroupUsersModel {
  int? orderPersonID;
  int? productID;
  int? orderStatus;
  double? subTotal;
  double? itemDiscount;
  double? shipping;
  double? total;
  String? promo;
  double? discount;
  double? grandTotal;
  int? quantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? content;
  String? userID;
  int? orderGroupID;

  GroupUsersModel(
      {this.orderPersonID,
        this.productID,
        this.orderStatus,
        this.subTotal,
        this.itemDiscount,
        this.shipping,
        this.total,
        this.promo,
        this.discount,
        this.grandTotal,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.content,
        this.userID,
        this.orderGroupID});

  GroupUsersModel.fromJson(Map<String, dynamic> json) {
    orderPersonID = Func.toInt(json['Order_person_ID']);
    productID = Func.toInt(json['ProductID']);
    orderStatus = Func.toInt(json['order_status']);
    subTotal = (json['subTotal'] == null? 0: Func.toDouble(json['subTotal']));
    itemDiscount = (json['ItemDiscount'] == null? 0: Func.toDouble(json['ItemDiscount']));
    shipping =(json['shipping'] == null? 0:  Func.toDouble(json['shipping']));
    total =(json['total'] == null? 0: Func.toDouble( json['total']));
    promo = (json['promo'] == null? "":  Func.toStr(json['promo']));
    discount = (json['discount'] == null? 0: Func.toDouble(json['discount']));
    grandTotal = Func.toDouble(json['grandTotal']);
    quantity = Func.toInt(json['quantity']);
    createdAt = Func.toDate( (json['createdAt'] == null? "1900-01-01":json['createdAt']));
    updatedAt = Func.toDate( (json['updatedAt'] == null? "1900-01-01": json['updatedAt']));
    content =(json['content'] == null? "": Func.toStr( json['content']));
    userID = (json['User_ID'] == null? "": Func.toStr(json['User_ID']));
    orderGroupID = Func.toInt(json['order_group_ID']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Order_person_ID'] = this.orderPersonID;
    data['ProductID'] = this.productID;
    data['order_status'] = this.orderStatus;
    data['subTotal'] = this.subTotal;
    data['ItemDiscount'] = this.itemDiscount;
    data['shipping'] = this.shipping;
    data['total'] = this.total;
    data['promo'] = this.promo;
    data['discount'] = this.discount;
    data['grandTotal'] = this.grandTotal;
    data['quantity'] = this.quantity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['content'] = this.content;
    data['User_ID'] = this.userID;
    data['order_group_ID'] = this.orderGroupID;
    return data;
  }
}
