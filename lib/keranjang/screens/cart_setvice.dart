import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<void> addToCart(int sneakerId, CookieRequest request, BuildContext context) async {
  final csrfToken = request.headers['X-CSRFToken']; // Ambil token CSRF dari request

  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/keranjang/add-to-cart-ajax/'),
      headers: {
        'X-CSRFToken': csrfToken ?? '',
      },
      body: {
        'sneaker': sneakerId.toString(),
        'quantity': '1', // Default quantity 1
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item added to cart successfully!')),
      );
    } else if (response.statusCode == 302) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to add items to cart!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add item to cart!')),
      );
    }
  } catch (e) {
    print('Error adding item to cart: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error adding item to cart!')),
    );
  }
}
