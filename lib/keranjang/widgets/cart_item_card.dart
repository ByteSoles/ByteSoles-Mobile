import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bytesoles/keranjang/models/cart_models.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRefresh;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.onRefresh,
  }) : super(key: key);

  Future<void> updateQuantity(String sneakerId, int quantity) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/keranjang/update-quantity/'),
        body: {
          'sneaker': sneakerId,
          'quantity': quantity.toString(),
        },
      );
      if (response.statusCode == 200) {
        onRefresh();
      }
    } catch (e) {
      print('Error updating quantity: $e');
    }
  }

  Future<void> removeItem(String sneakerId) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/keranjang/remove/'),
        body: {
          'sneaker': sneakerId,
        },
      );
      if (response.statusCode == 200) {
        onRefresh();
      }
    } catch (e) {
      print('Error removing item: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              item.sneakerImage,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.sneakerName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('\$${item.sneakerPrice}'),
                  Row(
                    children: [
                      const Text('Quantity: '),
                      DropdownButton<int>(
                        value: item.quantity,
                        items: List.generate(10, (i) => i + 1)
                            .map((i) => DropdownMenuItem(
                                  value: i,
                                  child: Text('$i'),
                                ))
                            .toList(),
                        onChanged: (value) async {
                          if (value != null) {
                            await updateQuantity(item.sneakerId, value);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${item.totalPrice}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () async {
                    await removeItem(item.sneakerId);
                  },
                  child: const Text(
                    'Remove',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
