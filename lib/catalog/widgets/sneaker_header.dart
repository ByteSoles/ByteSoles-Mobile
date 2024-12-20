import 'package:flutter/material.dart';

class SneakerHeader extends StatelessWidget {
  const SneakerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Judul tanpa background color
          const Text(
            'Shop Now, Goodlook Later',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Teks pendukung dengan warna abu-abu
          const Text(
            'We have a bunch collection for you! Let’s go explore and find your dream shoes, make it happen.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Garis pembatas dekoratif tipis
          Container(
            height: 1,
            width: 60,
            color: Colors.black26,
          ),
        ],
      ),
    );
  }
}
