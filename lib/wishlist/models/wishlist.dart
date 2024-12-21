// To parse this JSON data, do
//
//     final wishlist = wishlistFromJson(jsonString);

import 'dart:convert';

List<WishlistItem> wishlistFromJson(String str) => List<WishlistItem>.from(
    json.decode(str).map((x) => WishlistItem.fromJson(x)));

String wishlistToJson(List<WishlistItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WishlistItem {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String image;
  final String slug;

  WishlistItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.image,
    required this.slug,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      price: json['price'].toDouble(),
      image: json['image'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "brand": brand,
        "price": price,
        "image": image,
        "slug": slug,
      };
}
