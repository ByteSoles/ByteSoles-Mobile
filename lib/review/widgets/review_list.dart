import 'package:flutter/material.dart';
import 'package:bytesoles/review/models/review_entry.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({super.key});

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  Future<List<ReviewEntry>> fetchMood(CookieRequest request) async {
    final reviews = await request.get('http://127.0.0.1:8000/review/json/jordan-1-retro-high-og-patent-bred-jordan/');
    
    // Melakukan decode response menjadi bentuk json
    var data = reviews;
    
    // Melakukan konversi data json menjadi object ReviewEntry
    List<ReviewEntry> listReview = [];
    for (var d in data) {
      if (d != null) {
        listReview.add(ReviewEntry.fromJson(d));
      }
    }
    return listReview;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final request = context.watch<CookieRequest>();

    return FutureBuilder(
      future: fetchMood(request),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator()
          );
        } else {
          if (!snapshot.hasData) {
            return const Column(
              children: [
                Text(
                  'No Rewiew yet.',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                SizedBox(height: 8),
              ],
            );
          } else {
            return StaggeredGrid.count(
              crossAxisCount: screenWidth > 800 ? 2 : 1,
              crossAxisSpacing: 15,
              mainAxisSpacing: 13,
              children: [
                for (int i = 0; i < snapshot.data.length; i++)
                  ReviewCard(snapshot, i),
              ],
            );
          }
        }
      },
    );
  }
}

class ReviewCard extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int index;

  const ReviewCard(this.snapshot, this.index); 

  @override
  Widget build(BuildContext context) {
    int rating = snapshot.data![index].fields.score;
    String username = snapshot.data![index].fields.username;
    String reviewDescription = snapshot.data![index].fields.reviewDescription;
    String date = snapshot.data![index].fields.date.toString().substring(0, 10);

    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
            children: [
              for (int i = 0; i < 5; i++)
                Icon(
                  Icons.star_rounded,
                  color: i < rating ? Colors.yellow[600] : Colors.grey[300],
                  size: 23,
                ),
              ]
            ),
            const SizedBox(height: 10),
            Text(
              "By $username",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            Text(reviewDescription,
              style:  TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Reviewed on $date",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              )
            )
          ]
        )
      )
    );
  }
}