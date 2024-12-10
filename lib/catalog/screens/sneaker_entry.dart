import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bytesoles/catalog/models/sneaker.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:bytesoles/catalog/widgets/sneaker_card.dart'; // Impor SneakerCard
import 'package:bytesoles/catalog/widgets/recently_viewed.dart'; // Updated import path

class SneakerEntry extends StatefulWidget {
  const SneakerEntry({super.key});

  @override
  State<SneakerEntry> createState() => _SneakerEntryState();
}

class _SneakerEntryState extends State<SneakerEntry> {
  Future<List<Sneaker>> fetchSneakers(CookieRequest request) async {
    // Replace 10.0.2.2 with your computer's IP address when testing on a physical device
    // 10.0.2.2 is the special alias to your host machine when using Android emulator
    final response =
        await request.get('http://127.0.0.1:8000/catalog/view-json/');
        //await request.get('http://10.0.2.2:8000/catalog/view-json/');

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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final sneaker = snapshot.data![index];
                  return SneakerCard(sneaker: sneaker);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
