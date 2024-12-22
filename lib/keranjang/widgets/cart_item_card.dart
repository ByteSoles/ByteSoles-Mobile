import 'package:flutter/material.dart';
import 'package:bytesoles/keranjang/models/cart_item.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRefresh;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.onRefresh,
  }) : super(key: key);

  Future<void> updateQuantity(BuildContext context, int newQuantity) async {
    if (newQuantity < 1) return; 
    
    final request = context.read<CookieRequest>();
    try {
      final response = await request.post(
        "http://localhost:8000/keranjang/update-quantity-ajax/",
        {
          'sneaker': item.fields.sneaker.toString(),
          'quantity': newQuantity.toString(),
        },
      );

      if (response['status'] == 'success') {
        onRefresh(); 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Quantity successfully updated',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${item.fields.sneakerPrice}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => updateQuantity(
                          context, 
                          item.fields.quantity - 1
                        ),
                      ),
                      
                      Text(
                        '${item.fields.quantity}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => updateQuantity(
                          context, 
                          item.fields.quantity + 1
                        ),
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () async {
                    // Konfirmasi hapus item
                    bool? confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Remove Item'),
                        content: const Text('Are you sure you want to remove this item?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      final request = context.read<CookieRequest>();
                      try {
                        final response = await request.post(
                          "http://localhost:8000/keranjang/remove-from-cart-ajax/",
                          {'sneaker': item.fields.sneaker.toString()},
                        );

                        if (response['status'] == 'success') {
                          onRefresh();
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Item successfully removed',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black,
                            ),
                          );
                        }
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
