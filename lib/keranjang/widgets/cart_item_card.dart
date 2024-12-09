import 'package:flutter/material.dart';
import 'package:bytesoles/keranjang/models/cart_models.dart';
import 'package:bytesoles/keranjang/services/cart_service.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRefresh;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
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
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
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
                            // await CartService.updateQuantity(
                            //   item.sneakerId,
                            //   value,
                            // );
                            onRefresh();
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
                  'Total: \$${item.totalPrice}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () async {
                    // await CartService.removeItem(item.sneakerId);
                    onRefresh();
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