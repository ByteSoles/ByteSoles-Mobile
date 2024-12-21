import 'package:bytesoles/routes/app_routes.dart';
import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8), // Kurangi padding vertikal
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildFooterIcon(
              context,
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            _buildFooterIcon(
              context,
              icon: Icons.favorite_outline,
              label: 'Wishlist',
              onTap: () {
                Navigator.pushNamed(context, '/wishlist');
              },
            ),
            _buildFooterIcon(
              context,
              icon: Icons.shopping_cart_outlined,
              label: 'Cart',
              onTap: () {
                Navigator.pushNamed(context, '/cart');
              },
            ),
            _buildFooterIcon(
              context,
              icon: Icons.search_outlined,
              label: 'Search',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.catalogProductsScreen);
              },
            ),
            _buildFooterIcon(
              context,
              icon: Icons.settings_outlined,
              label: 'Profile',
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterIcon(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 24, // Sesuaikan ukuran ikon agar tidak terlalu besar
          ),
          const SizedBox(height: 4), // Kurangi jarak antara ikon dan teks
          Text(
            label,
            style: const TextStyle(
              fontSize: 12, // Kurangi ukuran font teks
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
