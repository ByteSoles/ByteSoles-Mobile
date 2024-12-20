import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bytesoles/catalog/models/sneaker.dart';
import 'package:bytesoles/catalog/widgets/recently_viewed.dart';
import 'package:bytesoles/widgets/header.dart';
import 'package:bytesoles/widgets/footer.dart';

class SneakerDetail extends StatefulWidget {
  final int sneakerId;

  const SneakerDetail({super.key, required this.sneakerId});

  @override
  State<SneakerDetail> createState() => _SneakerDetailState();
}

class _SneakerDetailState extends State<SneakerDetail> {
  late Future<Sneaker> futureSneaker;
  late Future<List<Sneaker>> futureRecentlyViewed;

  @override
  void initState() {
    super.initState();
    futureSneaker = fetchSneaker(widget.sneakerId);
    // Add current sneaker to recently viewed
    RecentlyViewedManager.addItem(widget.sneakerId);
    // Fetch recently viewed sneakers
    futureRecentlyViewed = fetchRecentlyViewed();
  }

  Future<Sneaker> fetchSneaker(int id) async {
    final request = context.read<CookieRequest>();
    final response =
        await request.get('http://127.0.0.1:8000/catalog/product_id/$id/');
    return Sneaker.fromJson(response);
  }

  Future<List<Sneaker>> fetchRecentlyViewed() async {
    final request = context.read<CookieRequest>();
    final recentIds = await RecentlyViewedManager.getItems();
    List<Sneaker> sneakers = [];

    // Remove current sneaker from the list
    recentIds.remove(widget.sneakerId);

    for (var id in recentIds) {
      try {
        final response =
            await request.get('http://127.0.0.1:8000/catalog/product_id/$id/');
        sneakers.add(Sneaker.fromJson(response));
      } catch (e) {
        print('Error fetching sneaker $id: $e');
      }
    }
    return sneakers;
  }

  Future<void> clearRecentlyViewed() async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Recently Viewed'),
          content: const Text(
              'Are you sure you want to clear all recently viewed items?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await RecentlyViewedManager.clearItems();
      setState(() {
        futureRecentlyViewed = fetchRecentlyViewed();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: CustomHeader(
      onMenuPressed: () => Scaffold.of(context).openDrawer(),
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Existing FutureBuilder for main sneaker details
            FutureBuilder<Sneaker>(
              future: futureSneaker,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(
                      child: Text('No sneaker details available.'));
                } else {
                  Sneaker sneaker = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          LayoutBuilder(
                            builder: (context, constraints) {
                              double imageWidth = constraints.maxWidth > 600
                                  ? 400
                                  : constraints.maxWidth;
                              double imageHeight = imageWidth * 0.75;

                              return Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      sneaker.fields.image,
                                      width: imageWidth,
                                      height: imageHeight,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const Icon(Icons.error,
                                            color: Colors.red, size: 50);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          // Product Information
                          Text(
                            sneaker.fields.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            sneaker.fields.brand,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '\$${sneaker.fields.price}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          // Release Date
                          Text(
                            'Release Date: ${sneaker.fields.releaseDate.toLocal().toString().split(' ')[0]}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          // Shoe Size Dropdown
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Select Shoe Size',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            items: ['38', '39', '40', '41', '42', '43', '44']
                                .map((size) => DropdownMenuItem(
                                    value: size, child: Text('Size $size')))
                                .toList(),
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: 20),
                          // Add to Cart Button
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.shopping_cart),
                            label: const Text('Add to Cart'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Add to Wishlist Button
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border),
                            label: const Text('Add to Wishlist'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Reviews Button
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.rate_review),
                            label: const Text('Reviews'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),

            // Recently Viewed Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recently Viewed',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: clearRecentlyViewed,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: FutureBuilder<List<Sneaker>>(
                future: futureRecentlyViewed,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No recently viewed items'));
                  }

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final sneaker = snapshot.data![index];
                      return Card(
                        margin: const EdgeInsets.only(right: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SneakerDetail(
                                  sneakerId: sneaker.pk,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 160,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(4),
                                  ),
                                  child: Image.network(
                                    sneaker.fields.image,
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        sneaker.fields.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        sneaker.fields.brand,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        '\$${sneaker.fields.price}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
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
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            CustomFooter(),
          ],
        ),
      ),
    );
  }
}
