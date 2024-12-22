import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import '../../widgets/header.dart';
import '../models/wishlist.dart';
import '../widgets/wishlist_card.dart';
import '../../routes/app_routes.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  String _selectedBrand = 'All';
  String _selectedSort = 'Recently Added';
  final List<String> _brands = ['All', 'Nike', 'adidas', 'Jordan', 'Crocs', 'New Balance', 'MSCHF', 'Puma'];
  final List<String> _sortOptions = ['Recently Added', 'Oldest First'];

  List<Wishlist> _filterAndSortWishlist(List<Wishlist> items) {
    var filteredItems = items.where((item) {
      return _selectedBrand == 'All' || item.brand == _selectedBrand;
    }).toList();

    // Sort items
    if (_selectedSort == 'Recently Added') {
      filteredItems = filteredItems.reversed.toList();
    }

    return filteredItems;
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'My Wishlist',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          Row(
            children: [
              // Sort Button
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                elevation: 2,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        MediaQuery.of(context).size.width - 160,
                        kToolbarHeight + 80,
                        16,
                        0,
                      ),
                      items: _sortOptions.map((String option) {
                        return PopupMenuItem<String>(
                          value: option,
                          child: Text(
                            option,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedSort = option;
                            });
                          },
                        );
                      }).toList(),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.sort, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          'Sort',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Filter Button
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                elevation: 2,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        MediaQuery.of(context).size.width - 80,
                        kToolbarHeight + 80,
                        16,
                        0,
                      ),
                      items: _brands.map((String brand) {
                        return PopupMenuItem<String>(
                          value: brand,
                          child: Text(
                            brand,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedBrand = brand;
                            });
                          },
                        );
                      }).toList(),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.filter_list, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          'Filter',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<List<Wishlist>> fetchWishlist() async {
    final request = context.read<CookieRequest>();
    try {
      final response = await request.get('http://localhost:8000/wishlist/json/');
      List<Wishlist> wishlistItems = [];
      
      for (var item in response) {
        wishlistItems.add(Wishlist.fromJson(item));
      }
      
      return wishlistItems;
    } catch (e) {
      throw Exception('Gagal mengambil data wishlist: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        isLoggedIn: context.read<CookieRequest>().loggedIn,
        onMenuPressed: () => Scaffold.of(context).openDrawer(),
        onLoginPressed: () => Navigator.pushNamed(context, AppRoutes.login),
      ),
      body: context.read<CookieRequest>().loggedIn 
        ? Column(
            children: [
              _buildHeader(),
              Expanded(
                child: FutureBuilder<List<Wishlist>>(
                  future: fetchWishlist(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }
                    
                    final wishlistItems = _filterAndSortWishlist(snapshot.data ?? []);
                    
                    if (wishlistItems.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Wishlist Anda masih kosong',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => Navigator.pushNamed(
                                context, 
                                AppRoutes.catalogProductsScreen
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Catalog',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 13,
                      ),
                      itemCount: wishlistItems.length,
                      itemBuilder: (context, index) {
                        return WishlistCard(
                          wishlist: wishlistItems[index],
                          onRemove: () => setState(() {}),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Silakan login untuk melihat wishlist Anda',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
    );
  }
}
