import 'package:bytesoles/keranjang/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final Future<void> onRefresh;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.onRefresh,
  }) : super(key: key);

  Future<void> updateQuantity(String sneakerId, int quantity) async {
    final csrfToken = 'your-csrf-token'; // Pastikan kamu mendapatkan token CSRF
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/keranjang/update-quantity-ajax/'),
        headers: {
          'X-CSRFToken': csrfToken,
        },
        body: {
          'sneaker': sneakerId,
          'quantity': quantity.toString(),
        },
      );
      if (response.statusCode == 200) {
        onRefresh; // Memanggil ulang refresh untuk memperbarui UI
      }
    } catch (e) {
      print('Error updating quantity: $e');
    }
  }

  Future<void> removeItem(BuildContext context, String sneakerId) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/keranjang/remove-from-cart-ajax/'),
        body: {
          'sneaker': sneakerId,
        },
      );
      if (response.statusCode == 200) {
        onRefresh; // Memanggil ulang refresh untuk memperbarui UI
      } else if (response.statusCode == 302) {
        // Jika pengalihan (redirect) terjadi, arahkan ke halaman login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You need to log in first!')),
        );
      }
    } catch (e) {
      print('Error removing item: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error removing item')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
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
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('\$${item.fields.sneakerPrice}'),
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
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$${item.fields.totalPrice}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () async {
                    await removeItem(
                        context, item.pk.toString()); // Pass context
                  },
                  child:
                      const Text('Remove', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
