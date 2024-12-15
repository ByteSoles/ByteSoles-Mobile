import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:bytesoles/catalog/screens/sneaker_entry.dart'; // Ganti dengan path file `SneakerEntry` Anda
import 'package:bytesoles/review/screens/review_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Bytesoles',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.brown,
          ).copyWith(secondary: Colors.brown[400]),
        ),
        home: ReviewPage(),
      ),
    );
  }
}


