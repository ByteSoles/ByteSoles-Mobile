import 'package:bytesoles/keranjang/screens/keranjang_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../app_theme.dart';
// import '../app_utils.dart' show ImageConstant;
import '../routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:bytesoles/userprofile/screens/profile_screen.dart';
import 'package:bytesoles/widgets/header.dart'; // Import CustomHeader
import 'package:bytesoles/widgets/footer.dart'; 

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
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KeranjangPage()),
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
                // Centered content
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

  Widget _buildFeatureItem({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/bg_catalog.png'),
          fit: BoxFit.cover,
        ),
          
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
      ),
    );
  }




  // Widget _buildFooterButton(BuildContext context, String text, String route) {
  //   return TextButton(
  //     onPressed: () => Navigator.pushNamed(context, route),
  //     child: Text(
  //       text,
  //       style: const TextStyle(color: Colors.white, fontSize: 14),
  //     ),
  //   );
  // }

  /// Widget untuk drawer
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
