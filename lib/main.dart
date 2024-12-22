import 'package:bytesoles/catalog/models/sneaker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'routes/app_routes.dart';
import 'screens/homepage.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'userprofile/screens/profile_screen.dart';
import 'package:bytesoles/catalog/screens/sneaker_entry.dart'; // Ganti dengan path file `SneakerEntry` Anda
import 'package:bytesoles/review/screens/review_page.dart';
import 'package:bytesoles/keranjang/screens/keranjang_page.dart';
import 'package:bytesoles/keranjang/screens/checkout_page.dart';
import 'package:bytesoles/catalog/screens/sneaker_detail.dart';
import 'package:bytesoles/wishlist/screens/wishlist_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CookieRequest(),
      child: MaterialApp(
        title: 'ByteSoles',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.home,
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.reviewPage) {
            final sneaker = settings.arguments as Sneaker;
            return MaterialPageRoute(
              builder: (context) => ReviewPage(sneaker: sneaker),
            );
          }
          if (settings.name == AppRoutes.wishlistScreen) {
            return MaterialPageRoute(
              builder: (context) => const WishlistScreen(),
            );
          }
          return null;

        },
        routes: {
          AppRoutes.home: (context) => const HomePage(),
          AppRoutes.login: (context) => const LoginPage(),
          AppRoutes.register: (context) => const RegisterPage(),
          AppRoutes.profile: (context) => const ProfileScreen(),
          AppRoutes.catalogProductsScreen: (context) => const SneakerEntry(),
          AppRoutes.keranjangPage: (context) => const KeranjangPage(),
          AppRoutes.checkoutPage: (context) => CheckoutSuccessPage(),
          AppRoutes.wishlistScreen: (context) => const WishlistScreen(),
        },
      ),
    );
  }
}
