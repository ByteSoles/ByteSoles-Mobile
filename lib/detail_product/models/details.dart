// To parse this JSON data, do
//
//     final productDetails = productDetailsFromJson(jsonString);

import 'dart:convert';

ProductDetails productDetailsFromJson(String str) =>
    ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  String model;
  int pk;
  Fields fields;

  ProductDetails({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
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
  String name;
  String brand;
  int price;
  String description;
  DateTime releaseDate;
  String slug;
  String image;

  Fields({
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.releaseDate,
    required this.slug,
    required this.image,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        brand: json["brand"],
        price: json["price"],
        description: json["description"],
        releaseDate: DateTime.parse(json["release_date"]),
        slug: json["slug"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "brand": brand,
        "price": price,
        "description": description,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "slug": slug,
        "image": image,
      };
}
