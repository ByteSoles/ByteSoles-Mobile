import 'package:bytesoles/keranjang/models/cart_models.dart';

class CartService {
  static Future<List<CartItem>> getCartItems() async {
    // Data dummy untuk testing
    return [
      CartItem(
        userId: "1",
        sneakerId: "1",
        sneakerName: "Nike Air Max",
        sneakerPrice: 150,
        sneakerImage: "https://example.com/nike.jpg",
        quantity: 2,
        totalPrice: 300,
      ),
    ];
  }

  static Future<UserCart> getUserCart() async {
    // Data dummy untuk testing
    return UserCart(
      userId: "1",
      totalItems: 2,
      totalPrice: 300,
    );
  }
}