import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bytesoles/keranjang/models/cart_models.dart';

// Add CartItem model
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
    required this.purchaseDate,
    this.totalPrice = 0,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      userId: json['user'].toString(),
      sneakerId: json['sneaker'].toString(),
      sneakerName: json['sneaker_name'],
      sneakerPrice: json['sneaker_price'],
      sneakerImage: json['sneaker_image'],
      quantity: json['quantity'] ?? 0,
      purchaseDate: DateTime.parse(json['purchase_date']),
      totalPrice: json['total_price'] ?? 0,
    );
  }
}

// Add UserCart model
class UserCart {
  final String userId;
  int totalItems;
  int totalPrice;

  UserCart({
    required this.userId,
    this.totalItems = 0,
    this.totalPrice = 0,
  });

  factory UserCart.fromJson(Map<String, dynamic> json) {
    return UserCart(
      userId: json['user'].toString(),
      totalItems: json['total_items'] ?? 0,
      totalPrice: json['total_price'] ?? 0,
    );
  }
}

class CartModels {
  // static const String baseUrl = 'http://10.0.2.2:8000'; // For Android emulator
  static const String baseUrl = 'http://127.0.0.1:8000'; // For iOS simulator

  static Future<List<CartItem>> fetchCartItems() async {
    final response = await http.get(
      Uri.parse('$baseUrl/keranjang/json/'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => CartItem.fromJson(item['fields'])).toList();
    }
    throw Exception('Failed to load cart items');
  }

  static Future<UserCart> fetchUserCart() async {
    final response = await http.get(
      Uri.parse('$baseUrl/keranjang/get-cart/'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return UserCart.fromJson(data[0]['fields']);
    }
    throw Exception('Failed to load user cart');
  }

  static Future<void> updateQuantity(String sneakerId, int quantity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/keranjang/update-quantity/'),
      body: {
        'sneaker': sneakerId,
        'quantity': quantity.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update quantity');
    }
  }

  static Future<void> removeItem(String sneakerId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/keranjang/remove/'),
      body: {'sneaker': sneakerId},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove item');
    }
  }
}
