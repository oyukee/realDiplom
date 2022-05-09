import 'dart:convert';

import '../utils/Func.dart';

class CartListResponse {
  final List<CartModel> list;

  CartListResponse({
    required this.list,
  });

  factory CartListResponse.fromJson(List<dynamic> parsedJson) {
    List<CartModel> list;//= new List<UserResponse>();
    list = parsedJson.map((i) => CartModel.fromJson(i)).toList();

    return new CartListResponse(list: list);
  }
}
class CartModel {
  int? Cart_ID;
  String? User_ID;
  int? status;
  String? User_Fname;
  String? User_Lname;
  String? User_Phone1;
  String? User_Email;
  String? line1;
  String? line2;
  String? City;
  String? province;
  String? Country;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? content;
  String? imageUrl;

  CartModel(
      {this.Cart_ID,
        this.User_ID,
        this.User_Fname,
        this.User_Lname,
        this.User_Phone1,
        this.User_Email,
        this.City,
        this.line1,
        this.line2,
        this.province,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.Country,
        this.content,
        this.imageUrl});



  CartModel.fromJson(Map<String, dynamic> json) {
    Cart_ID =  Func.toInt(json['Cart_ID']);
    User_ID = json['User_ID'];
    User_Fname = json['User_Fname'];
    User_Lname = json['User_Lname'];
    User_Phone1 = json['User_Phone1'];
    User_Email = json['User_Email'];
    line1 = json['line1'];
    line2 = json['line2'];
    province = json['province'];
    City = json['City'];
    status = Func.toInt(json['status']);
    createdAt = Func.toDate(json['createdAt']==null?'': json['createdAt']);
    updatedAt = Func.toDate(json['updatedAt']==null?'': json['updatedAt']);
    Country =json['Country'];
    content = json['content'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Cart_ID'] = this.Cart_ID;
    data['User_ID'] = this.User_ID;
    data['User_Fname'] = this.User_Fname;
    data['User_Lname'] = this.User_Lname;
    data['User_Phone1'] = this.User_Phone1;
    data['User_Email'] = this.User_Email;
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    data['province'] = this.province;
    data['City'] = this.City;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['Country'] = this.Country;
    data['content'] = this.content;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
