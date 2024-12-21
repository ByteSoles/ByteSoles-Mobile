import 'package:flutter/material.dart';
import 'package:bytesoles/keranjang/widgets/cart_list.dart';
import 'package:bytesoles/keranjang/models/cart_item.dart';
import 'package:bytesoles/keranjang/models/user_cart.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  List<CartItem> cartItems = [];
  UserCart? userCart;
  bool isLoading = true;
  bool itemAdded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final request = context.read<CookieRequest>();
      refreshCartItems(request);
    });
  }

Future<void> refreshCartItems(CookieRequest request) async {
  setState(() => isLoading = true);

  try {
    final responseCartItem = await request.get("http://localhost:8000/keranjang/json/");
    final responseUserCart = await request.get("http://localhost:8000/keranjang/get-user-cart/");

    if (responseCartItem is List) {
      final List<CartItem> listCart = responseCartItem.map<CartItem>((data) {
        return CartItem.fromJson(data as Map<String, dynamic>);
      }).toList();

      final userCartData = UserCart.fromJson(responseUserCart as Map<String, dynamic>);

      setState(() {
        cartItems = listCart;
        userCart = userCartData;
        isLoading = false;
      });
    } else {
      throw Exception('Invalid response format for cart items');
    }
  } catch (e) {
    setState(() => isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error loading cart data: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
              ? const Center(
                  child: Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : CartList(
                  cartItems: cartItems,
                  userCart: userCart!,
                  onRefresh: () => refreshCartItems(request),
                  itemAdded: itemAdded,
                ),
    );
  }
}
