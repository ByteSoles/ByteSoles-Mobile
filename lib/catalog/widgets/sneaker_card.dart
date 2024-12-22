import 'package:flutter/material.dart';
import 'package:bytesoles/catalog/models/sneaker.dart';
import 'package:bytesoles/catalog/screens/sneaker_detail.dart';

class SneakerCard extends StatelessWidget {
  final Sneaker sneaker;

  const SneakerCard({Key? key, required this.sneaker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imageUrl = sneaker.fields.image;
    // Dapatkan lebar layar
    final screenWidth = MediaQuery.of(context).size.width;
    // Hitung lebar card (2 card per baris dengan padding)
    final cardWidth = (screenWidth - 32) / 2; // 32 adalah total padding horizontal
    // Hitung tinggi gambar yang proporsional
    final imageHeight = cardWidth * 0.8; // Rasio aspek 0.8

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SneakerDetail(sneakerId: sneaker.pk),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        child: Card(
          margin: const EdgeInsets.all(4.0),
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Tambahkan ini
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl,
                  height: imageHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: imageHeight,
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sneaker.fields.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      sneaker.fields.brand,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${sneaker.fields.price}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
