import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bytesoles/catalog/models/sneaker.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:bytesoles/catalog/widgets/sneaker_card.dart';
import 'package:bytesoles/widgets/header.dart'; // Import CustomHeader

class SneakerEntry extends StatefulWidget {
  const SneakerEntry({super.key});

  @override
  State<SneakerEntry> createState() => _SneakerEntryState();
}

class _SneakerEntryState extends State<SneakerEntry> {
  List<Sneaker> allSneakers = [];
  List<Sneaker> displayedSneakers = [];
  String selectedBrand = 'All';
  String selectedSortOption = 'Default';
  Set<String> availableBrands = {'All'};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final request = context.read<CookieRequest>();
      fetchSneakers(request);
    });
  }

  Future<void> fetchSneakers(CookieRequest request) async {
    final response =
        await request.get('http://127.0.0.1:8000/catalog/view-json/');
    List<Sneaker> sneakers = [];
    for (var d in response) {
      if (d != null) {
        sneakers.add(Sneaker.fromJson(d));
      }
    }

    Set<String> brands = {'All'};
    for (var sneaker in sneakers) {
      brands.add(sneaker.fields.brand);
    }

    setState(() {
      allSneakers = sneakers;
      displayedSneakers = List.from(allSneakers);
      availableBrands = brands;
    });
  }

  void filterByBrand(String brand) {
    setState(() {
      selectedBrand = brand;
      if (brand == 'All') {
        displayedSneakers = List.from(allSneakers);
      } else {
        displayedSneakers =
            allSneakers.where((s) => s.fields.brand == brand).toList();
      }
    });
  }

  void sortSneakers(String sortOption) {
    setState(() {
      selectedSortOption = sortOption;
      if (sortOption == 'Price: Low to High') {
        displayedSneakers
            .sort((a, b) => a.fields.price.compareTo(b.fields.price));
      } else if (sortOption == 'Price: High to Low') {
        displayedSneakers
            .sort((a, b) => b.fields.price.compareTo(a.fields.price));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        isLoggedIn: context.read<CookieRequest>().loggedIn,
        onMenuPressed: () => Scaffold.of(context).openDrawer(),
        onLoginPressed: () {
          Navigator.pushNamed(context, '/login');
        },
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '100+ Items',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _showSortOptions(),
                      icon: const Icon(Icons.sort, size: 18),
                      label: const Text('Sort'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => _showFilterOptions(),
                      icon: const Icon(Icons.filter_alt, size: 18),
                      label: const Text('Filter'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          displayedSneakers.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Belum ada data sneakers yang tersedia.',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: displayedSneakers.length,
                    itemBuilder: (_, index) {
                      final sneaker = displayedSneakers[index];
                      return SneakerCard(sneaker: sneaker);
                    },
                  ),
                ),
        ],
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: availableBrands.map((brand) {
            return ListTile(
              title: Text(brand),
              onTap: () {
                filterByBrand(brand);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: const Text('Default'),
              onTap: () {
                sortSneakers('Default');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Price: Low to High'),
              onTap: () {
                sortSneakers('Price: Low to High');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Price: High to Low'),
              onTap: () {
                sortSneakers('Price: High to Low');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
