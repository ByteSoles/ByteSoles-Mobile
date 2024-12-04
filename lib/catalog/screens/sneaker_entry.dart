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
        title: const Text('Sneaker Entry List'),
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
