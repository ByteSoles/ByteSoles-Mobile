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
      model: '', // Nilai default
      pk: 0, // Nilai default
      fields: UserCartModel.Fields(
          user: 0, totalItems: 0, totalPrice: 0), // Menggunakan alias
    );

    setState(() => isLoading = true);

    try {
      final responseCartItem =
          await request.get("http://localhost:8000/keranjang/json/");
      final responseUserCart =
          await request.get("http://localhost:8000/keranjang/get-user-cart/");

      // Parsing cart item data
      for (var d in responseCartItem) {
        if (d != null) {
          listCart.add(CartItem.fromJson(d));
        }
      }

      // Parsing user cart data dengan UserCart.fromJson
      for (var d in responseUserCart) {
        if (d != null) {
          cart = UserCart.fromJson(
              d); // Memastikan data diubah menjadi objek UserCart
        }
      }

      setState(() {
        cartItems = listCart;
        userCart = cart; // Setelah data diparsing, set userCart
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
    // refreshCartItems(request);
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
        centerTitle: true, // Untuk memposisikan judul di tengah seperti di gambar
        backgroundColor: Colors.white, // Sesuai dengan desain yang light
        elevation: 0, // Menghilangkan shadow
        iconTheme: const IconThemeData(color: Colors.black), // Warna icon back button
        titleTextStyle: const TextStyle(color: Colors.black), // Warna text judul
      ),
      body: cartItems.isEmpty
          ? const EmptyCart()
          : CartList(
              cartItems: cartItems,
              userCart: userCart!,
              onRefresh: () => refreshCartItems(request), // Referensi fungsi
              itemAdded: itemAdded,
            ),
    );
  }
}

