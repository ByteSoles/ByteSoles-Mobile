import 'package:flutter/foundation.dart';

// Model untuk UserCart
class UserCart {
  final String userId;
  int totalItems;
  int totalPrice;

  UserCart({
    required this.userId,
    this.totalItems = 0,
    this.totalPrice = 0,
  });

  // Konversi dari JSON
  factory UserCart.fromJson(Map<String, dynamic> json) {
    return UserCart(
      userId: json['user_id'],
      totalItems: json['total_items'] ?? 0,
      totalPrice: json['total_price'] ?? 0,
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'total_items': totalItems,
      'total_price': totalPrice,
    };
  }
}

// Model untuk CartItem
class CartItem {
  final String userId;
  final String sneakerId;
  final String sneakerName;
  final int sneakerPrice;
  final String sneakerImage;
  int quantity;
  final DateTime purchaseDate;
  int totalPrice;

  CartItem({
    required this.userId,
    required this.sneakerId,
    required this.sneakerName,
    required this.sneakerPrice,
    required this.sneakerImage,
    this.quantity = 0,
    DateTime? purchaseDate,
    this.totalPrice = 0,
  }) : this.purchaseDate = purchaseDate ?? DateTime.now();

  // Konversi dari JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      userId: json['user_id'],
      sneakerId: json['sneaker_id'],
      sneakerName: json['sneaker_name'],
      sneakerPrice: json['sneaker_price'] ?? 0,
      sneakerImage: json['sneaker_image'],
      quantity: json['quantity'] ?? 0,
      purchaseDate: DateTime.parse(json['purchase_date']),
      totalPrice: json['total_price'] ?? 0,
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'sneaker_id': sneakerId,
      'sneaker_name': sneakerName,
      'sneaker_price': sneakerPrice,
      'sneaker_image': sneakerImage,
      'quantity': quantity,
      'purchase_date': purchaseDate.toIso8601String(),
      'total_price': totalPrice,
    };
  }
}
import 'package:flutter/foundation.dart';

// Model untuk UserCart
class UserCart {
  final String userId;
  int totalItems;
  int totalPrice;

  UserCart({
    required this.userId,
    this.totalItems = 0,
    this.totalPrice = 0,
  });

  // Konversi dari JSON
  factory UserCart.fromJson(Map<String, dynamic> json) {
    return UserCart(
      userId: json['user_id'],
      totalItems: json['total_items'] ?? 0,
      totalPrice: json['total_price'] ?? 0,
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'total_items': totalItems,
      'total_price': totalPrice,
    };
  }
}

// Model untuk CartItem
class CartItem {
  final String userId;
  final String sneakerId;
  final String sneakerName;
  final int sneakerPrice;
  final String sneakerImage;
  int quantity;
  final DateTime purchaseDate;
  int totalPrice;

  CartItem({
    required this.userId,
    required this.sneakerId,
    required this.sneakerName,
    required this.sneakerPrice,
    required this.sneakerImage,
    this.quantity = 0,
    DateTime? purchaseDate,
    this.totalPrice = 0,
  }) : this.purchaseDate = purchaseDate ?? DateTime.now();

  // Konversi dari JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      userId: json['user_id'],
      sneakerId: json['sneaker_id'],
      sneakerName: json['sneaker_name'],
      sneakerPrice: json['sneaker_price'] ?? 0,
      sneakerImage: json['sneaker_image'],
      quantity: json['quantity'] ?? 0,
      purchaseDate: DateTime.parse(json['purchase_date']),
      totalPrice: json['total_price'] ?? 0,
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'sneaker_id': sneakerId,
      'sneaker_name': sneakerName,
      'sneaker_price': sneakerPrice,
      'sneaker_image': sneakerImage,
      'quantity': quantity,
      'purchase_date': purchaseDate.toIso8601String(),
      'total_price': totalPrice,
    };
  }
}