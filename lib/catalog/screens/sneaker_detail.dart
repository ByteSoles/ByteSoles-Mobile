import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bytesoles/catalog/models/sneaker.dart';

class SneakerDetail extends StatefulWidget {
  final int sneakerId;

  const SneakerDetail({super.key, required this.sneakerId});

  @override
  State<SneakerDetail> createState() => _SneakerDetailState();
}

class _SneakerDetailState extends State<SneakerDetail> {
  late Future<Sneaker> futureSneaker;

  @override
  void initState() {
    super.initState();
    // Initialize the future when the state is created
    futureSneaker = fetchSneaker(widget.sneakerId);
  }

  Future<Sneaker> fetchSneaker(int id) async {
    final request = context.read<CookieRequest>();

    //final response = await request
       // .get('http://192.168.1.100.7:8000/catalog/product_id/$id/');
    final response = await request.get('http://10.0.2.2:8000/catalog/product_id/$id/');

    if (response.isEmpty || response == null) {
      throw Exception('No data found for this sneaker.');
    }

    try {
      return Sneaker.fromJson(response);
    } catch (e) {
      throw Exception('Failed to parse sneaker data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shoe Details'),
      ),
      body: FutureBuilder<Sneaker>(
        future: futureSneaker,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while fetching data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Display error message if an error occurs
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            // Display message if no data is found
            return const Center(
              child: Text(
                'No sneaker details available.',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            );
          } else {
            // If data is successfully fetched, display the details
            Sneaker sneaker = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                // Added to prevent overflow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sneaker Image
                    Center(
                      child: Image.network(
                        sneaker.fields.image,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Sneaker Name
                    Text(
                      sneaker.fields.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Sneaker Description
                    Text(
                      sneaker.fields.releaseDate.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    // Additional Details (e.g., Price, Size, etc.)
                    Row(
                      children: [
                        const Text(
                          'Price: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${sneaker.fields.price}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
