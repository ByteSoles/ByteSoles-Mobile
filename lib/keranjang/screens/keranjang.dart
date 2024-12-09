import 'package:flutter/material.dart';
import 'package:bytesoles/keranjang/widgets/empty_cart.dart';
import 'package:bytesoles/keranjang/widgets/cart_content.dart';
import 'package:bytesoles/keranjang/models/cart_models.dart';
import 'package:bytesoles/keranjang/services/cart_service.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  List<CartItem> cartItems = [];
  UserCart? userCart;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    refreshCartItems();
  }

  Future<void> refreshCartItems() async {
    setState(() => isLoading = true);
    try {
      final items = await CartService.getCartItems();
      final cart = await CartService.getUserCart();
      setState(() {
        cartItems = items;
        userCart = cart;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: cartItems.isEmpty
          ? const EmptyCart()
          : CartContent(
              cartItems: cartItems,
              userCart: userCart!,
              onRefresh: refreshCartItems,
            ),
    );
  }
}