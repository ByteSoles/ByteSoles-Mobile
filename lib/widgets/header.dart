import 'package:bytesoles/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

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

  void _handleWishlistNavigation(BuildContext context) {
    final request = context.read<CookieRequest>();
    if (request.loggedIn) {
      Navigator.pushNamed(context, AppRoutes.wishlistScreen);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Required'),
            content: const Text('Please login to access your wishlist'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.login);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                child: const Text('Login'),
              ),
            ],
          );
        },
      );
    }
  }

  void _handleCartNavigation(BuildContext context) {
    final request = context.read<CookieRequest>();
    if (request.loggedIn) {
      Navigator.pushNamed(context, AppRoutes.keranjangPage);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Required'),
            content: const Text('Please login to access your cart'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.login);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                child: const Text('Login'),
              ),
            ],
          );
        },
      );
    }
  }

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
          child: InkWell(
            onTap: () {
              if (isLoggedIn) {
                Navigator.pushNamed(context, '/profile');
              } else {
                Navigator.pushNamed(context, '/login');
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

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
            _handleWishlistNavigation(context);
            break;
          case 'Buy More':
            Navigator.pushNamed(context, AppRoutes.catalogProductsScreen);
            break;
          case 'List Cart':
            _handleCartNavigation(context);
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
