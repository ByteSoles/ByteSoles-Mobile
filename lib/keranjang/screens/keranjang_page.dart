import 'package:bytesoles/catalog/screens/sneaker_entry.dart';
import 'package:bytesoles/keranjang/models/user_cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bytesoles/keranjang/widgets/empty_cart.dart';
import 'package:bytesoles/keranjang/widgets/cart_list.dart';
import 'package:bytesoles/keranjang/models/cart_item.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

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
    final request = context.read<CookieRequest>();
    super.initState();
    refreshCartItems(request);
  }

  Future<void> refreshCartItems(CookieRequest request) async {
    List<CartItem> listCart = [];
    UserCart cart;
    setState(() => isLoading = true);
    try {
      // Fetch cart items from Django
      final responseCartItem =
          await request.get("http://localhost:8000/keranjang/json/");
      for (var d in responseCartItem) {
        if (d != null) {
          listCart.add(CartItem.fromJson(d));
        }
      }
      // Fetch user cart from Django
      final responseUserCart =
          await request.get("http://localhost:8000/keranjang/get-user-cart/");
      for (var d in responseUserCart) {
        if (d != null) {
          cart = UserCart.fromJson(d);
        }
      }

      // if (responseCartItem.statusCode == 200 && responseCartItem.statusCode == 200) {
        // final List<dynamic> itemsJson = jsonDecode(itemsResponse.body);
        // final List<dynamic> cartJson = jsonDecode(cartResponse.body);

        setState(() {
          // cartItems = itemsJson
          //     .map((item) => CartItem.fromJson(item['fields']))
          //     .toList();
          // userCart = CartItem.fromJson(cartJson[0]['fields']);
          cartItems = listCart;
          for (var d in responseUserCart) {
            if (d != null) {
              userCart = UserCart.fromJson(d);
            }
          }
          isLoading = false;
        });
      }
    catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading cart data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    // refreshCartItems(request);
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
              onRefresh: refreshCartItems(request),
              itemAdded: itemAdded,
            ),
    );
  }
}
