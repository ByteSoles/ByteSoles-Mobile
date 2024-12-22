import 'package:bytesoles/routes/app_routes.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuPressed;
  final VoidCallback? onLoginPressed;
  final bool isLoggedIn;

  const CustomHeader({
    super.key,
    this.onMenuPressed,
    this.onLoginPressed,
    this.isLoggedIn = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 56,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: _buildMenuButton(context),
      centerTitle: true,
      title: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRoutes.home),
        child: const Text(
          'ByteSoles',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: isLoggedIn
              ? InkWell(
                  onTap: onLoginPressed,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/profile.png',
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : TextButton(
                  onPressed: onLoginPressed,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text(
                    'Login/Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  /// Button Menu untuk menampilkan daftar menu
  Widget _buildMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu, color: Colors.black),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onSelected: (value) {
        switch (value) {
          case 'Homepage':
            Navigator.pushNamed(context, AppRoutes.home);
            break;
          case 'Wishlist':
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Wishlist page coming soon!')),
            );
            break;
          case 'Buy More':
            Navigator.pushNamed(context, AppRoutes.catalogProductsScreen);
            break;
          case 'List Cart':
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cart page coming soon!')),
            );
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'Homepage',
          child: ListTile(
            leading: Icon(Icons.home, color: Colors.black),
            title: Text('Homepage'),
          ),
        ),
        const PopupMenuItem(
          value: 'Wishlist',
          child: ListTile(
            leading: Icon(Icons.favorite_border, color: Colors.black),
            title: Text('Wishlist'),
          ),
        ),
        const PopupMenuItem(
          value: 'Buy More',
          child: ListTile(
            leading: Icon(Icons.shopping_cart_outlined, color: Colors.black),
            title: Text('Buy More'),
          ),
        ),
        const PopupMenuItem(
          value: 'List Cart',
          child: ListTile(
            leading: Icon(Icons.receipt_long, color: Colors.black),
            title: Text('List Cart'),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
