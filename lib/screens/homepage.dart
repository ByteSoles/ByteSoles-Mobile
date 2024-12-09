import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../app_theme.dart';
import '../app_utils.dart' show ImageConstant;
import '../routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

// ignore_for_file: must_be_immutable
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
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 22),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "Hello, $username!",
                    textAlign: TextAlign.center,
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
                  child: Column(
                    children: [_buildHomeScreenList(context)],
                  ),
                ),
                const SizedBox(height: 20),
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 56,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leadingWidth: 75,
      leading: Padding(
        padding: const EdgeInsets.only(
          left: 43,
          top: 12,
          bottom: 12,
        ),
        child: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          constraints: const BoxConstraints(
            minHeight: 32,
            minWidth: 32,
          ),
          padding: EdgeInsets.zero,
          icon: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: LightCodeColors.gray10001,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(4),
            child: SvgPicture.asset(
              ImageConstant.imgComponent1,
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        "Bytesoles",
        style: theme.textTheme.bodyLarge,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            right: 40,
            bottom: 8,
          ),
          child: isLoggedIn
              ? InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile page coming soon!')),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/profile.png',
                      height: 40,
                      width: 42,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text(
                    'Login/Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildImageSlider(BuildContext context) {
    final List<String> imageAssets = [
      'assets/images/hp1.jpg',
      'assets/images/hp2.jpg',
      'assets/images/hp3.jpg',
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
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
                activeDotColor: LightCodeColors.redA200,
                dotColor: LightCodeColors.gray300,
                activeDotScale: 1.25,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildHomeScreenList(BuildContext context) {
    // List judul dan fungsi onTap untuk masing-masing box
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Catalog',
        'onTap': () => Navigator.pushNamed(context, AppRoutes.catalogProductsScreen),
      },
      {
        'title': 'Wishlist',
        'onTap': () {
          // Sementara hanya tampilkan snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wishlist page coming soon!')),
          );
        },
      },
      {
        'title': 'Cart',
        'onTap': () {
          // Sementara hanya tampilkan snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cart page coming soon!')),
          );
        },
      },
    ];

    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 36);
      },
      itemCount: items.length,
      itemBuilder: (context, index) {
        return HomescreenlistItemWidget(
          title: items[index]['title'],
          onTapImgCatalogone: items[index]['onTap'],
        );
      },
    );
  }

  /// Navigates to the catalogProductsScreen when the action is triggered.
  onTapImgCatalogone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.catalogProductsScreen);
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            '© 2024 Byte Soles. All rights reserved.',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pushNamed(
                  context, 
                  AppRoutes.catalogProductsScreen
                ),
                child: const Text(
                  'Catalog',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cart page coming soon!')),
                  );
                },
                child: const Text(
                  'Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Wishlist page coming soon!')),
                  );
                },
                child: const Text(
                  'Wishlist',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Handle item 1 tap
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Handle item 2 tap
            },
          ),
        ],
      ),
    );
  }
}

class HomescreenlistItemWidget extends StatelessWidget {
  HomescreenlistItemWidget({
    Key? key, 
    required this.title,
    this.onTapImgCatalogone,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTapImgCatalogone;
  final theme = ThemeHelper.themeData();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 204,
      margin: const EdgeInsets.only(right: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadiusStyle.roundedBorder16,
            onTap: onTapImgCatalogone,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                children: [
                  // Background Image
                  Image.asset(
                    'assets/images/bg_catalog.png',
                    height: 204,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                  // Overlay gelap untuk membuat teks lebih terbaca
                  Container(
                    height: 204,
                    width: double.maxFinite,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ),
          // Text di tengah
          Text(
            title,
            style: theme.textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class CustomImageView extends StatelessWidget {
  const CustomImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 244,
      width: 410,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              16,
            ),
            child: Image.asset(
              ImageConstant.imgUnsplashNovnxxmdni0,
              height: 244,
              width: double.maxFinite,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 40,
              width: 42,
              margin: const EdgeInsets.only(
                right: 12,
                bottom: 82,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusStyle.circleBorder20,
                gradient: LinearGradient(
                  begin: Alignment(0.49, 0.51),
                  end: Alignment(0.49, 1.48),
                  colors: [
                    LightCodeColors.gray40001,
                    LightCodeColors.gray40001.withOpacity(0)
                  ],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 24,
                    width: 26,
                    child: SvgPicture.asset(
                      ImageConstant.imgArrowRight,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


