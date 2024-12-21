import 'package:flutter/material.dart';
import 'package:bytesoles/catalog/models/sneaker.dart';
import 'package:bytesoles/detail_product/screens/sneaker_detail.dart';

class SneakerCard extends StatelessWidget {
  final Sneaker sneaker;

  const SneakerCard({Key? key, required this.sneaker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gambar URL dari API
    final String imageUrl = sneaker.fields.image;

    return GestureDetector(
      onTap: () {
        // Navigate to the SneakerDetail page when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SneakerDetail(sneakerId: sneaker.pk),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            // Menampilkan gambar sneaker
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Menampilkan informasi sneaker menggunakan Flex dan Expanded
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama sneaker dengan font bold
                  Text(
                    sneaker.fields.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Brand sneaker
                  Text(
                    sneaker.fields.brand,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Harga sneaker
                  Text(
                    '\$${sneaker.fields.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Tanggal rilis sneaker (optional)
                  // You can uncomment and format the release date if needed
                  /*
                  Text(
                    'Released on: ${sneaker.fields.releaseDate.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
