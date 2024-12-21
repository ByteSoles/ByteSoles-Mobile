import 'package:bytesoles/app_theme.dart';
import 'package:bytesoles/catalog/models/sneaker.dart';
import 'package:bytesoles/catalog/screens/sneaker_detail.dart';
// import 'package:bytesoles/keranjang/screens/keranjang_page.dart';
import 'package:bytesoles/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/header.dart'; // Import CustomHeader
import '../widgets/footer.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int sliderIndex = 0;
  final theme = ThemeHelper.themeData();
  String username = "User";
  bool isLoggedIn = false;
  List<Sneaker> sneakers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final request = context.read<CookieRequest>();
      if (request.loggedIn) {
        setState(() {
          username = request.jsonData['username'] ?? "User";
          isLoggedIn = true;
        });
      }
      fetchSneakers(request); // Fetch sneakers on initialization
    });
  }

    Future<void> fetchSneakers(CookieRequest request) async {
    final response = await request.get('http://127.0.0.1:8000/catalog/view-json/');
    List<Sneaker> fetchedSneakers = [];
    for (var d in response) {
      if (d != null) {
        fetchedSneakers.add(Sneaker.fromJson(d));
      }
    }

    setState(() {
      sneakers = fetchedSneakers.take(8).toList(); // Ambil hanya 6 sneaker pertama
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: _buildDrawer(context),
        appBar: CustomHeader(
          isLoggedIn: isLoggedIn,
          onMenuPressed: () => Scaffold.of(context).openDrawer(),
          onLoginPressed: () => Navigator.pushNamed(context, AppRoutes.login),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "Hello, $username!",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              const SizedBox(height: 18),
              _buildImageSlider(context),
              const SizedBox(height: 34),
              _buildSneakersSection(), // Bagian sneakers ditampilkan di sini
              const SizedBox(height: 34),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: _buildHomeScreenList(context),
              ),
              const SizedBox(height: 20),
              CustomFooter(),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget untuk slider gambar
  Widget _buildImageSlider(BuildContext context) {
    final List<String> imageAssets = [
      'assets/images/hp1.jpg',
      'assets/images/hp2.jpg',
      'assets/images/hp3.jpg',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlutterCarousel(
          options: CarouselOptions(
            height: 244,
            autoPlay: true,
            viewportFraction: 0.85,
            showIndicator: false,
            initialPage: 0,
            padEnds: true,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() {
                sliderIndex = index;
              });
            },
          ),
          items: imageAssets.map((asset) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  asset,
                  height: 244,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: sliderIndex,
            count: imageAssets.length,
            effect: ScrollingDotsEffect(
              spacing: 8.0,
              activeDotColor: Colors.black,
              dotColor: Colors.grey,
              activeDotScale: 1.25,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
        ),
      ],
    );
  }

  
  Widget _buildSneakersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "It's trending now",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,AppRoutes.catalogProductsScreen
                  );
                },
                child: const Text(
                  'See More..',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: PageView.builder(
            itemCount: (sneakers.length / 4).ceil(),
            controller: PageController(viewportFraction: 0.9),
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * 4;
              final endIndex = (startIndex + 4).clamp(0, sneakers.length);

              final currentSneakers = sneakers.sublist(startIndex, endIndex);

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: currentSneakers.map((sneaker) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SneakerDetail(sneakerId: sneaker.pk),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                sneaker.fields.image,
                                width: 120,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  Text(
                                    sneaker.fields.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
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
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }


  Widget _buildHomeScreenList(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        'title': 'Catalog',
        'description': 'Browse our extensive collection of sneakers.',
        'icon': Icons.search,
        'onTap': () => Navigator.pushNamed(context, AppRoutes.catalogProductsScreen),
      },
      {
        'title': 'Wishlist',
        'description': 'Save your favorite sneakers for later.',
        'icon': Icons.favorite_border,
        'onTap': () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Wishlist page coming soon!')),
            ),
      },
      {
        'title': 'Cart',
        'description': 'Manage your selected items and checkout.',
        'icon': Icons.shopping_cart,
        'onTap': () => Navigator.pushNamed(
              context,
              AppRoutes.keranjangPage,
            ),
      },
    ];

    return Column(
      children: features.map((feature) {
        return GestureDetector(
          onTap: feature['onTap'],
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/images/bg_catalog.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          feature['icon'],
                          size: 50,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          feature['title'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          feature['description'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () => Navigator.pushNamed(context, '/home'),
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
    );
  }
}

