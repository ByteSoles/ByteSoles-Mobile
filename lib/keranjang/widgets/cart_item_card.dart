import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bytesoles/keranjang/models/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final Future<void> onRefresh;

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
        onRefresh;
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
        onRefresh;
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
              item.fields.sneakerImage,
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
                    item.fields.sneakerName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('\$${item.fields.sneakerPrice}'),
                  Row(
                    children: [
                      const Text('Quantity: '),
                      DropdownButton<int>(
                        value: item.fields.quantity,
                        items: List.generate(10, (i) => i + 1)
                            .map((i) => DropdownMenuItem(
                                  value: i,
                                  child: Text('$i'),
                                ))
                            .toList(),
                        onChanged: (value) async {
                          if (value != null) {
                            await updateQuantity(item.pk.toString(), value);
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
                  '\$${item.fields.totalPrice}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () async {
                    await removeItem(item.pk.toString());
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
