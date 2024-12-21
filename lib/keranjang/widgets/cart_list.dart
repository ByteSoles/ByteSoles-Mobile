import 'package:bytesoles/keranjang/models/user_cart.dart';
import 'package:flutter/material.dart';
import 'package:bytesoles/keranjang/widgets/cart_item_card.dart';
import 'package:bytesoles/keranjang/widgets/order_summary.dart';
import 'package:bytesoles/keranjang/models/cart_item.dart';

class CartList extends StatelessWidget {
  final List<CartItem> cartItems;
  final UserCart userCart;
  final Future<void> Function()
      onRefresh; // Pastikan tipe ini adalah Future<void> Function()
  final bool itemAdded;

  const CartList({
    Key? key,
    required this.cartItems,
    required this.userCart,
    required this.onRefresh,
    required this.itemAdded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (itemAdded)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Item successfully added to your cart!'),
              ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartItems.length,
              itemBuilder: (context, index) => CartItemCard(
                item: cartItems[index],
                onRefresh:
                    onRefresh, // Berikan referensi fungsi onRefresh tanpa tanda kurung
              ),
            ),
            OrderSummary(userCart: userCart),
          ],
        ),
      ),
    );
  }
}
