// import 'package:bytesoles/keranjang/widgets/cart_item_card.dart';
// import 'package:bytesoles/keranjang/screens/cart_setvice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'routes/app_routes.dart';
import 'screens/homepage.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'userprofile/screens/profile_screen.dart';
import 'package:bytesoles/catalog/screens/sneaker_entry.dart'; // Ganti dengan path file `SneakerEntry` Anda
import 'package:bytesoles/keranjang/screens/keranjang_page.dart';
import 'package:bytesoles/keranjang/screens/checkout_page.dart';

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
        routes: {
          AppRoutes.home: (context) => const HomePage(),
          AppRoutes.login: (context) => const LoginPage(),
          AppRoutes.register: (context) => const RegisterPage(),
          AppRoutes.profile: (context) => const ProfileScreen(),
          AppRoutes.catalogProductsScreen: (context) => const SneakerEntry(),
          AppRoutes.keranjangPage: (context) => const KeranjangPage(),
          AppRoutes.checkoutPage: (context) => CheckoutSuccessPage(),

          // Tambahkan route lainnya jika diperlukan
        },
      ),
    );
  }
}
