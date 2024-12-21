import 'package:bytesoles/keranjang/models/user_cart.dart';
import 'package:bytesoles/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:bytesoles/keranjang/models/cart_item.dart';

class OrderSummary extends StatefulWidget {
  final UserCart userCart;

  const OrderSummary({
    Key? key,
    required this.userCart,
  }) : super(key: key);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  late UserCart userCart;

  @override
  void initState() {
    super.initState();
    userCart = widget.userCart; // Initialize with the passed userCart
  }

  @override
  Widget build(BuildContext context) {
    int totalItems = userCart.fields.totalItems;
    int totalPrice = userCart.fields.totalPrice;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$totalItems Items'),
              Text('\$$totalPrice'),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery'),
              Text('FREE'),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '\$$totalPrice',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Payment Method',
            ),
            items: const [
              DropdownMenuItem(value: 'BCA', child: Text('BCA')),
              DropdownMenuItem(value: 'BNI', child: Text('BNI')),
              DropdownMenuItem(value: 'Mandiri', child: Text('Mandiri')),
              DropdownMenuItem(value: 'BRI', child: Text('BRI')),
              DropdownMenuItem(value: 'CIMB', child: Text('CIMB')),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Pindah ke route checkoutPage
                Navigator.pushNamed(context, AppRoutes.checkoutPage);

                // Menampilkan snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cart page coming soon!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
