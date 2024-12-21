import 'package:flutter/material.dart';
import '../models/wishlist_item.dart';
import 'wishlist_card.dart';

class WishlistGrid extends StatelessWidget {
  final List<WishlistItem> wishlistItems;
  final Function(int) onRemove;

  const WishlistGrid({
    super.key,
    required this.wishlistItems,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: wishlistItems.length,
      itemBuilder: (context, index) {
        return WishlistCard(
          wishlist: wishlistItems[index],
          onRemove: onRemove,
        );
      },
    );
  }
}
