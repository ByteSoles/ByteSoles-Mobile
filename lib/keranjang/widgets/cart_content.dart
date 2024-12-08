import 'package:flutter/material.dart';
import 'bytesoles/models/test.dart';
import 'bytesoles/widgets/cart_item_card.dart';
import 'bytesoles/widgets/order_summary.dart';

class CartContent extends StatelessWidget {
  final List<CartItem> cartItems;
  final UserCart userCart;
  final VoidCallback onRefresh;

  const CartContent({
    Key? key,
    required this.cartItems,
    required this.userCart,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Bag',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return CartItemCard(
                item: cartItems[index],
                onRefresh: onRefresh,
              );
            },
          ),
          const SizedBox(height: 20),
          OrderSummary(userCart: userCart),
        ],
      ),
    );
  }
}