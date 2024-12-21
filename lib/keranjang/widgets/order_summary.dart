import 'package:flutter/material.dart';
import 'package:bytesoles/keranjang/models/user_cart.dart';

class OrderSummary extends StatelessWidget {
  final UserCart userCart;

  const OrderSummary({Key? key, required this.userCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 2),
        const SizedBox(height: 12),
        Text(
          'TOTAL: (${userCart.fields.totalItems} items)',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '\$${userCart.fields.totalPrice}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ],
    );
  }
}
