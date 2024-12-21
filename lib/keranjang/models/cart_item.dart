// To parse this JSON data, do
//
//     final cartItem = cartItemFromJson(jsonString);

import 'dart:convert';

List<CartItem> cartItemFromJson(String str) =>
    List<CartItem>.from(json.decode(str).map((x) => CartItem.fromJson(x)));

String cartItemToJson(List<CartItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartItem {
  String model;
  int pk;
  Fields fields;

  CartItem({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
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
  int sneaker;
  String sneakerName;
  int sneakerPrice;
  String sneakerImage;
  int quantity;
  DateTime purchaseDate;
  int totalPrice;

  Fields({
    required this.user,
    required this.sneaker,
    required this.sneakerName,
    required this.sneakerPrice,
    required this.sneakerImage,
    required this.quantity,
    required this.purchaseDate,
    required this.totalPrice,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        sneaker: json["sneaker"],
        sneakerName: json["sneaker_name"],
        sneakerPrice: json["sneaker_price"],
        sneakerImage: json["sneaker_image"],
        quantity: json["quantity"],
        purchaseDate: DateTime.parse(json["purchase_date"]),
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "sneaker": sneaker,
        "sneaker_name": sneakerName,
        "sneaker_price": sneakerPrice,
        "sneaker_image": sneakerImage,
        "quantity": quantity,
        "purchase_date": purchaseDate.toIso8601String(),
        "total_price": totalPrice,
      };
}
