// To parse this JSON data, do
//
//     final sneaker = sneakerFromJson(jsonString);

import 'dart:convert';

List<Sneaker> sneakerFromJson(String str) => List<Sneaker>.from(json.decode(str).map((x) => Sneaker.fromJson(x)));

String sneakerToJson(List<Sneaker> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sneaker {
    String model;
    int pk;
    Fields fields;

    Sneaker({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Sneaker.fromJson(Map<String, dynamic> json) => Sneaker(
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
    DateTime releaseDate;
    String image;
    String slug;

    Fields({
        required this.name,
        required this.brand,
        required this.price,
        required this.releaseDate,
        required this.image,
        required this.slug,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        brand: json["brand"],
        price: json["price"],
        releaseDate: DateTime.parse(json["release_date"]),
        image: json["image"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "brand": brand,
        "price": price,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "image": image,
        "slug": slug,
    };
}
