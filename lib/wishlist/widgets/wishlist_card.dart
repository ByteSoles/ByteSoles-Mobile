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
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                wishlist.image,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            
            // Nama Produk
            Text(
              wishlist.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            
            // Brand
            Text(
              wishlist.brand,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            
            // Harga
            Text(
              '\$${wishlist.price}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const Spacer(),
            
            // Tombol Hapus
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final request = context.read<CookieRequest>();
                  try {
                    final response = await request.post(
                      'https://daffa-aqil31-bytesoles.pbp.cs.ui.ac.id/wishlist/remove/${wishlist.id}/',
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
                            content: Text('Item berhasil dihapus dari wishlist'),
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
                        content: Text('Gagal menghapus item: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  minimumSize: const Size(double.infinity, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Hapus',
                  style: TextStyle(
                    fontSize: 12,
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
