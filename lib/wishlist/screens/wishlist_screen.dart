import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // Simulasi data wishlist
  List<String> wishlistItems = []; // Kosong saat belum ada data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        title: const Text(
          'Bytesoles',
          style: TextStyle(
            color: Color(0xFF161616),
            fontSize: 18,
            fontFamily: 'Madimi One',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian header yang tetap ada
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  wishlistItems.isEmpty ? '0 Items' : '${wishlistItems.length} Items',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (wishlistItems.isNotEmpty)
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.sort, color: Colors.black),
                        onPressed: () {
                          // TODO: Tambahkan logika sorting
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.filter_list, color: Colors.black),
                        onPressed: () {
                          // TODO: Tambahkan logika filter
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),

          // Konten utama
          Expanded(
            child: wishlistItems.isEmpty
                ? _buildEmptyWishlist(context)
                : _buildWishlistWithItems(),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan wishlist kosong
  Widget _buildEmptyWishlist(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 24),
          const Text(
            'Your Wishlist is Empty',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Login to save your favorite items and create your wishlist',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigasi ke halaman katalog
              Navigator.pop(context); // Sementara hanya kembali
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Browse Catalog',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan wishlist dengan item
  Widget _buildWishlistWithItems() {
    return ListView.builder(
      itemCount: wishlistItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.favorite, color: Colors.red),
          title: Text(wishlistItems[index]),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.grey),
            onPressed: () {
              setState(() {
                wishlistItems.removeAt(index); // Hapus item dari wishlist
              });
            },
          ),
        );
      },
    );
  }
}
