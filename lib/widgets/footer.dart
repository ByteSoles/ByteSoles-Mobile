import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const Text(
            '© 2024 Byte Soles. All rights reserved.',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 15),
          const Text(
            'Made by: Yovan, Dapqil, Caca, Farhan, Qibas',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
