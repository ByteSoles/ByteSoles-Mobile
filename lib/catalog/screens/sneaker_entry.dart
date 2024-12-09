import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bytesoles/catalog/models/sneaker.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class SneakerEntry extends StatefulWidget {
  const SneakerEntry({super.key});

  @override
  State<SneakerEntry> createState() => _SneakerEntryState();
}

class _SneakerEntryState extends State<SneakerEntry> {
  Future<List<Sneaker>> fetchSneakers(CookieRequest request) async {
    // Ganti URL dengan endpoint API yang benar
    final response = await request.get('http://127.0.0.1:8000/catalog/view-json/');

    // Melakukan decode response menjadi bentuk json
    var data = response;

    // Konversi data json menjadi object Sneaker
    List<Sneaker> listSneakers = [];
    for (var d in data) {
      if (d != null) {
        listSneakers.add(Sneaker.fromJson(d));
      }
    }
    return listSneakers;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
      ),
      body: FutureBuilder(
        future: fetchSneakers(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada data sneakers yang tersedia.',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                final sneaker = snapshot.data![index];

                // print(sneaker.fields.image);
                
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${sneaker.fields.name}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Brand: ${sneaker.fields.brand}'),
                        Text('Price: \$${sneaker.fields.price}'),
                        Text('Release Date: ${sneaker.fields.releaseDate}'),
                        Image.network(
                          sneaker.fields.image,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            if (sneaker.fields.slug.contains('jordan-1-mid-white-metallic-gold-obsidian-jordan')) {
                              return Image.asset('assets/images/placeholder1.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-air-force-1-low-supreme-black-nike')) {
                              return Image.asset('assets/images/placeholder2.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-dunk-low-retro-white-black-panda-2021-gs-nike')) {
                              return Image.asset('assets/images/placeholder3.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('adidas-campus-80s-south-park-towelie-adidas')) {
                              return Image.asset('assets/images/placeholder4.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('new-balance-550-white-green-new-balance')) {
                              return Image.asset('assets/images/placeholder5.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('new-balance-2002r-protection-pack-rain-cloud-new-balance')) {
                              return Image.asset('assets/images/placeholder6.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-dunk-low-grey-fog-nike')) {
                              return Image.asset('assets/images/placeholder7.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-dunk-low-next-nature-white-black-panda-womens-nike')) {
                              return Image.asset('assets/images/placeholder8.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('new-balance-550-white-black-new-balance')) {
                              return Image.asset('assets/images/placeholder9.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('jordan-1-low-bred-toe-jordan')) {
                              return Image.asset('assets/images/placeholder10.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('jordan-1-retro-high-og-patent-bred-jordan')) {
                              return Image.asset('assets/images/placeholder11.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('new-balance-550-white-grey-new-balance')) {
                              return Image.asset('assets/images/placeholder12.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('adidas-yeezy-boost-350-v2-onyx-adidas')) {
                              return Image.asset('assets/images/placeholder13.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('adidas-yeezy-slide-onyx-adidas')) {
                              return Image.asset('assets/images/placeholder14.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-dunk-low-next-nature-white-mint-womens-nike')) {
                              return Image.asset('assets/images/placeholder15.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('adidas-yeezy-boost-350-v2-bone-adidas')) {
                              return Image.asset('assets/images/placeholder16.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('jordan-4-retro-military-black-jordan')) {
                              return Image.asset('assets/images/placeholder17.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('adidas-yeezy-slide-bone-2022-restock-adidas')) {
                              return Image.asset('assets/images/placeholder18.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('adidas-yeezy-slide-flax-adidas')) {
                              return Image.asset('assets/images/placeholder19.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-air-max-1-prm-dirty-denim-nike')) {
                              return Image.asset('assets/images/placeholder20.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('crocs-pollex-clog-by-salehe-bembury-tide-crocs')) {
                              return Image.asset('assets/images/placeholder21.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('adidas-yeezy-slide-resin-2022-adidas')) {
                              return Image.asset('assets/images/placeholder22.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('jordan-1-retro-high-og-taxi-jordan')) {
                              return Image.asset('assets/images/placeholder23.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-kd-15-aunt-pearl-nike')) {
                              return Image.asset('assets/images/placeholder24.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-dunk-low-qs-lebron-james-fruity-pebbles-nike')) {
                              return Image.asset('assets/images/placeholder25.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-dunk-low-retro-white-pure-platinum-nike')) {
                              return Image.asset('assets/images/placeholder26.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-dunk-low-arizona-state-nike')) {
                              return Image.asset('assets/images/placeholder27.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('jordan-1-retro-high-og-gorge-green-jordan')) {
                              return Image.asset('assets/images/placeholder28.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('jordan-2-retro-og-chicago-2022-jordan')) {
                              return Image.asset('assets/images/placeholder29.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('jordan-1-low-se-reverse-ice-blue-womens-jordan')) {
                              return Image.asset('assets/images/placeholder30.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('crocs-mega-crush-sandal-black-crocs')) {
                              return Image.asset('assets/images/placeholder31.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('jordan-1-low-se-concord-jordan')) {
                              return Image.asset('assets/images/placeholder32.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('jordan-1-low-true-blue-jordan')) {
                              return Image.asset('assets/images/placeholder33.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('jordan-1-mid-se-space-jam-jordan')) {
                              return Image.asset('assets/images/placeholder34.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-dunk-low-retro-prm-valentines-day-2023-nike')) {
                              return Image.asset('assets/images/placeholder35.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('mschf-big-red-boot-mschf')) {
                              return Image.asset('assets/images/placeholder36.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('jordan-6-retro-cool-grey-jordan')) {
                              return Image.asset('assets/images/placeholder37.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-air-force-1-low-sp-ambush-phantom-nike')) {
                              return Image.asset('assets/images/placeholder38.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-dunk-low-active-fuchsia-gs-nike')) {
                              return Image.asset('assets/images/placeholder39.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('jordan-1-low-unity-womens-jordan')) {
                              return Image.asset('assets/images/placeholder40.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-air-zoom-generation-first-game-2023-nike')) {
                              return Image.asset('assets/images/placeholder41.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('jordan-1-retro-high-og-chicago-lost-and-found-jordan')) {
                              return Image.asset('assets/images/placeholder42.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            } else if (sneaker.fields.slug.contains('nike-dunk-low-industrial-blue-sashiko-nike')) {
                              return Image.asset('assets/images/placeholder43.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            }
                            
                             else {
                              return Image.asset('assets/images/default_fallback.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                            }
                          },
                        ),

                        const SizedBox(height: 8),
                        Text('Slug: ${sneaker.fields.slug}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
