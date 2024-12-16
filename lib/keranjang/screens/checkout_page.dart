import 'package:bytesoles/catalog/screens/sneaker_entry.dart';
import 'package:bytesoles/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:bytesoles/keranjang/widgets/success_header.dart';
import 'package:bytesoles/keranjang/widgets/purchase_history.dart';
import 'package:bytesoles/keranjang/models/cart_item.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CheckoutSuccessPage extends StatelessWidget {
  int totalPrice = 0;
  List<CartItem> items = [];

  CheckoutSuccessPage({
    super.key,
    // required this.items,
    // required this.totalPrice,
  });
  Future<List<CartItem>> getCartItem (CookieRequest request) async {
    List<CartItem> listCart = [];
    try{
      final response = await request.get("http://localhost:8000/keranjang/json/");
      for(var d in response){
        if(d != null){
          listCart.add(CartItem.fromJson(d));
        }
      }
    }catch(e){

    }
    return listCart;
  }



  @override
  Widget build(BuildContext context) {
    List<CartItem> items = [];
    int totalPrice;
    final request = context.watch<CookieRequest>();
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
            child: SingleChildScrollView(
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
        Icon(
          Icons.check_circle,
          size: 64,
          color: Colors.green[600],
        ),
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
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
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
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // items.map((item) => _buildPurchaseItem(item)).toList(),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Total: \$$totalPrice',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
      child: Column(
        children: [
          Row(
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
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text('Quantity: ${item.fields.quantity}'),
                  ],
                ),
              ),
              Text(
                '\$${item.fields.totalPrice}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text('Give Review'),
            ),
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
