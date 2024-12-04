import 'package:flutter/material.dart';
import 'package:bytesoles/catalog/models/sneaker.dart';

class SneakerCard extends StatelessWidget {
  final Sneaker sneaker;

  const SneakerCard({super.key, required this.sneaker});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${sneaker.fields.name}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Brand: ${sneaker.fields.brand}'),
            Text('Price: \$${sneaker.fields.price}'),
            Text('Release Date: ${sneaker.fields.releaseDate}'),
            Image.network(
              sneaker.fields.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text('Slug: ${sneaker.fields.slug}'),
          ],
        ),
      ),
    );
  }
}
