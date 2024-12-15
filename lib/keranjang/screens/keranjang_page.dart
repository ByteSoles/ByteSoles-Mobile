import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bytesoles/keranjang/widgets/empty_cart.dart';
import 'package:bytesoles/keranjang/widgets/cart_list.dart';
import 'package:bytesoles/keranjang/models/cart_models.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  List<CartItem> cartItems = [];
  UserCart? userCart;
  bool isLoading = true;
  bool itemAdded = false;

  @override
  void initState() {
    super.initState();
    refreshCartItems();
  }

  Future<void> refreshCartItems() async {
    setState(() => isLoading = true);
    try {
      // Fetch cart items from Django
      final itemsResponse = await http.get(
        Uri.parse('http://localhost:8000/keranjang/json/'),
        headers: {
          "Content-Type": "application/json",
        },
      );

      // Fetch user cart from Django
      final cartResponse = await http.get(
        Uri.parse('http://localhost:8000/keranjang/get-cart/'),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (itemsResponse.statusCode == 200 && cartResponse.statusCode == 200) {
        final List<dynamic> itemsJson = jsonDecode(itemsResponse.body);
        final List<dynamic> cartJson = jsonDecode(cartResponse.body);

        setState(() {
          cartItems = itemsJson
              .map((item) => CartItem.fromJson(item['fields']))
              .toList();
          userCart = UserCart.fromJson(cartJson[0]['fields']);
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading cart data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: cartItems.isEmpty
          ? const EmptyCart()
          : CartList(
              cartItems: cartItems,
              userCart: userCart!,
              onRefresh: refreshCartItems,
              itemAdded: itemAdded,
            ),
    );
  }
}
