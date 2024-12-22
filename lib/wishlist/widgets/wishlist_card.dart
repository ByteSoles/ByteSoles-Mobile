import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import '../models/wishlist.dart';
// import '../utils/cookie_request.dart';

class WishlistCard extends StatelessWidget {
  final Wishlist wishlist;
  final VoidCallback? onRemove;
  
  const WishlistCard({
    super.key,
    required this.wishlist,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                wishlist.image,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            
            // Nama Produk
            Text(
              wishlist.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            
            // Brand
            Text(
              wishlist.brand,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 8),
            
            // Harga
            Text(
              '\$${wishlist.price}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Tombol Hapus
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final request = context.read<CookieRequest>();
                  try {
                    final response = await request.post(
                      'http://localhost:8000/wishlist/remove/${wishlist.id}/',
                      {
                        'user': request.jsonData['user_id'].toString(),
                        'sneaker': wishlist.id.toString(),
                      },
                    );
                    
                    if (!context.mounted) return;
                    
                    if (response['status'] == 'success') {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Item berhasil dihapus dari wishlist',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.black,
                          ),
                        );
                      }
                      if (onRemove != null) onRemove!();
                    } else {
                      throw Exception(response['message'] ?? 'Gagal menghapus item');
                    }
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Gagal menghapus item: $e',
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.black,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Hapus dari Wishlist',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
