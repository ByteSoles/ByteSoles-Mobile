import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../models/wishlist_item.dart';
import '../widgets/wishlist_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<WishlistItem> _wishlistItems = [];
  String _selectedBrand = 'all';
  RangeValues _currentRangeValues = const RangeValues(50, 500);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWishlist();
  }

  Future<void> fetchWishlist() async {
    if (!mounted) return;

    final request = context.read<CookieRequest>();
    try {
      final response =
          await request.get('http://localhost:8000/wishlist/json/');
      if (!mounted) return;

      if (response != null) {
        setState(() {
          _wishlistItems = (response as List)
              .map((item) => WishlistItem.fromJson(item))
              .toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal memuat wishlist")),
      );
    }
  }

  List<WishlistItem> getFilteredItems() {
    return _wishlistItems.where((item) {
      final brandMatch =
          _selectedBrand == 'all' || item.brand == _selectedBrand;
      final priceMatch = item.price >= _currentRangeValues.start &&
          item.price <= _currentRangeValues.end;
      return brandMatch && priceMatch;
    }).toList();
  }

  Future<void> removeFromWishlist(int productId) async {
    if (!mounted) return;

    final request = context.read<CookieRequest>();
    try {
      final response = await request.post(
        'http://localhost:8000/wishlist/remove/$productId/',
        {
          'user': request.jsonData['user_id'].toString(),
        },
      );

      if (!mounted) return;

      if (response['status'] == 'success') {
        setState(() {
          _wishlistItems.removeWhere((item) => item.id == productId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Berhasil menghapus dari wishlist")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menghapus dari wishlist")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final filteredItems = getFilteredItems();

    if (!request.loggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Wishlist'),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Anda harus login untuk melihat wishlist',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                DropdownButton<String>(
                  value: _selectedBrand,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All Brands')),
                    DropdownMenuItem(value: 'Jordan', child: Text('Jordan')),
                    DropdownMenuItem(value: 'Nike', child: Text('Nike')),
                    DropdownMenuItem(value: 'adidas', child: Text('adidas')),
                    DropdownMenuItem(
                        value: 'New Balance', child: Text('New Balance')),
                    DropdownMenuItem(value: 'Crocs', child: Text('Crocs')),
                    DropdownMenuItem(value: 'MSCHF', child: Text('MSCHF')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedBrand = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text('Price Range'),
                RangeSlider(
                  values: _currentRangeValues,
                  min: 50,
                  max: 500,
                  divisions: 45,
                  labels: RangeLabels(
                    '\$${_currentRangeValues.start.round()}',
                    '\$${_currentRangeValues.end.round()}',
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredItems.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Your wishlist is empty',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Explore sneakers',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: filteredItems.length,
                        itemBuilder: (ctx, i) =>
                            buildWishlistCard(filteredItems[i]),
                      ),
          ),
        ],
      ),
    );
  }

  Widget buildWishlistCard(WishlistItem item) {
    return WishlistCard(
      wishlist: item,
      onRemove: removeFromWishlist,
    );
  }
}
