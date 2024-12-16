// To parse this JSON data, do
//
//     final wishlist = wishlistFromJson(jsonString);

import 'dart:convert';

List<Wishlist> wishlistFromJson(String str) => List<Wishlist>.from(json.decode(str).map((x) => Wishlist.fromJson(x)));

String wishlistToJson(List<Wishlist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Wishlist {
    int id;
    String name;
    String brand;
    String price;
    String image;
    String slug;

    Wishlist({
        required this.id,
        required this.name,
        required this.brand,
        required this.price,
        required this.image,
        required this.slug,
    });

    factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        id: json["id"],
        name: json["name"],
        brand: json["brand"],
        price: json["price"],
        image: json["image"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "brand": brand,
        "price": price,
        "image": image,
        "slug": slug,
    };
}
