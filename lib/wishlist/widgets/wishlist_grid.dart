import 'package:flutter/material.dart';
import '../models/wishlist.dart';
import 'wishlist_card.dart';

class WishlistGrid extends StatelessWidget {
  const WishlistGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 13,
        mainAxisSpacing: 13,
      ),
      itemBuilder: (context, index) {
        // Contoh data dummy, nanti ganti dengan data asli
        final dummyWishlist = Wishlist(
          id: 1,
          name: 'Nike Air Force 1 Low \'07 Black Black',
          brand: 'Nike',
          price: '100',
          image: 'https://via.placeholder.com/180x153',
          slug: 'nike-air-force-1',
        );
        
        return WishlistCard(wishlist: dummyWishlist);
      },
    );
  }
}
