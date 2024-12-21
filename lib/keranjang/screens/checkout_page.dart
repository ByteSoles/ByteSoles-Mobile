import 'package:bytesoles/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:bytesoles/keranjang/models/cart_item.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CheckoutSuccessPage extends StatefulWidget {
  const CheckoutSuccessPage({super.key});

  @override
  _CheckoutSuccessPageState createState() => _CheckoutSuccessPageState();
}

class _CheckoutSuccessPageState extends State<CheckoutSuccessPage> {
  List<CartItem> items = [];
  int totalPrice = 0;
  bool isLoading = true;

  // Fetch cart items from Django
  Future<void> fetchCartItems(CookieRequest request) async {
    try {
      final response =
          await request.get("http://localhost:8000/keranjang/json/");
      final List<CartItem> fetchedItems =
          response.map<CartItem>((item) => CartItem.fromJson(item)).toList();

      // Calculate the total price
      int calculatedTotalPrice = 0;
      for (var item in fetchedItems) {
        calculatedTotalPrice += item.fields.totalPrice;
      }

      // Update state
      setState(() {
        items = fetchedItems;
        totalPrice = calculatedTotalPrice;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching cart items: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final request = context.watch<CookieRequest>();
    fetchCartItems(request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/tes.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.6),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator() // Show loading indicator
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSuccessMessage(),
                        const SizedBox(height: 24),
                        _buildPurchaseHistory(),
                        const SizedBox(height: 24),
                        _buildReturnButton(context),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Column(
      children: [
        Icon(Icons.check_circle, size: 64, color: Colors.green[600]),
        const SizedBox(height: 16),
        const Text(
          'Payment Successful!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const Text(
          'Thank you for your purchase.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPurchaseHistory() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'Your Purchase History',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...items.map((item) => _buildPurchaseItem(item)).toList(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Total: \$$totalPrice',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(
            item.fields.sneakerImage,
            width: 64,
            height: 64,
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
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text('Quantity: ${item.fields.quantity}'),
              ],
            ),
          ),
          Text(
            '\$${item.fields.totalPrice}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildReturnButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      child: const Text('Return to Homepage'),
    );
  }
}