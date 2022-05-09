import 'dart:convert';

import '../utils/Func.dart';

class UserListResponse {
  final List<UserResponse> list;

  UserListResponse({
    required this.list,
  });

  factory UserListResponse.fromJson(List<dynamic> parsedJson) {
    List<UserResponse> list;//= new List<UserResponse>();
    list = parsedJson.map((i) => UserResponse.fromJson(i)).toList();

    return new UserListResponse(list: list);
  }
}

class UserResponse {
  UserResponse({ required this.id, required this.name, required this.email});

  int id;
  String name;
  String email;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      UserResponse(
        id: Func.toInt(json["id"]),
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
