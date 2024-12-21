// To parse this JSON data, do
//
//     final userCart = userCartFromJson(jsonString);

import 'dart:convert';

List<UserCart> userCartFromJson(String str) =>
    List<UserCart>.from(json.decode(str).map((x) => UserCart.fromJson(x)));

String userCartToJson(List<UserCart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserCart {
  String model;
  int pk;
  Fields fields;

  UserCart({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory UserCart.fromJson(Map<String, dynamic> json) => UserCart(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  int totalItems;
  int totalPrice;

  Fields({
    required this.user,
    required this.totalItems,
    required this.totalPrice,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        totalItems: json["total_items"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "total_items": totalItems,
        "total_price": totalPrice,
      };
}