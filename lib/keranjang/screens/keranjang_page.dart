import 'package:bytesoles/catalog/screens/sneaker_entry.dart';
import 'package:bytesoles/keranjang/models/user_cart.dart';
import 'package:bytesoles/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bytesoles/keranjang/widgets/empty_cart.dart';
import 'package:bytesoles/keranjang/widgets/cart_list.dart';
import 'package:bytesoles/keranjang/models/cart_item.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bytesoles/keranjang/models/cart_item.dart' as CartItemModel;
import 'package:bytesoles/keranjang/models/user_cart.dart' as UserCartModel;

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
    UserCart cart = UserCart(
      model: '', 
      pk: 0, 
      fields: UserCartModel.Fields(
          user: 0, totalItems: 0, totalPrice: 0), 
    );

    setState(() => isLoading = true);

    try {
      final responseCartItem =
          await request.get("http://localhost:8000/keranjang/json/");
      final responseUserCart =
          await request.get("http://localhost:8000/keranjang/get-user-cart/");

      for (var d in responseCartItem) {
        if (d != null) {
          listCart.add(CartItem.fromJson(d));
        }
      }

      for (var d in responseUserCart) {
        if (d != null) {
          cart = UserCart.fromJson(d); 
        }
      }

      setState(() {
        cartItems = listCart;
        userCart = cart;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading cart data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.home);
          },
        ),
        title: const Text(
          'Your Cart',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),

        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
        elevation: 0, 
        iconTheme: const IconThemeData(color: Colors.black), 
        titleTextStyle: const TextStyle(color: Colors.black), 
      ),
      body: cartItems.isEmpty
          ? const EmptyCart()
          : CartList(
              cartItems: cartItems,
              userCart: userCart!,
              onRefresh: () => refreshCartItems(request), 
              itemAdded: itemAdded,
            ),
    );
  }
}

