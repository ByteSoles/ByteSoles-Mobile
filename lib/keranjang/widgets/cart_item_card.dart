import 'package:flutter/material.dart';
import 'package:bytesoles/keranjang/models/cart_item.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final Future<void> Function() onRefresh;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.onRefresh,
  }) : super(key: key);

  Future<void> removeItem(BuildContext context, String sneakerId) async {
    final request = context.read<CookieRequest>();
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/keranjang/remove-from-cart-ajax/'),
        headers: {'X-CSRFToken': request.headers['X-CSRFToken'] ?? ''},
        body: {'sneaker': sneakerId},
      );

      if (response.statusCode == 200) {
        await onRefresh();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to remove item from cart')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Sneaker Image
            Image.network(
              item.fields.sneakerImage,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),

            // Sneaker Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.fields.sneakerName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${item.fields.sneakerPrice}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Quantity:'),
                      const SizedBox(width: 8),
                      Text('${item.fields.quantity}'),
                    ],
                  ),
                ],
              ),
            ),

            // Total and Remove Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Total: \$${item.fields.totalPrice}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => removeItem(context, item.pk.toString()),
                  child: const Text('Remove', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
