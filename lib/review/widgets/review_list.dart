import 'package:flutter/material.dart';
import 'package:bytesoles/review/models/review_entry.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewList extends StatefulWidget {
  final String slug;
  final String? username;

  const ReviewList({Key? key, required this.slug, required this.username}) : super(key: key);

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  Future<List<ReviewEntry>> fetchReviews(CookieRequest request) async {
    final reviews = await request.get('https://daffa-aqil31-bytesoles.pbp.cs.ui.ac.id/review/json/${widget.slug}/');
    var data = reviews;
    
    List<ReviewEntry> listReview = [];
    for (var d in data) {
      if (d != null) {
        listReview.add(ReviewEntry.fromJson(d));
      }
    }
    return listReview;
  }

  void refreshReviews() {
    setState(() {
      // Trigger a rebuild of the FutureBuilder to fetch the latest reviews
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final request = context.watch<CookieRequest>();

    return FutureBuilder(
      future: fetchReviews(request),
      builder: (context, AsyncSnapshot reviewsSnapshot) {
        if (reviewsSnapshot.data == null) {
          return Center(
            child: CircularProgressIndicator()
          );
        } else {
          if (!reviewsSnapshot.hasData || reviewsSnapshot.data == null || reviewsSnapshot.data.length == 0) {
            return Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'No Review yet.',
                    style: TextStyle(
                    fontSize: 16, 
                    color: Colors.grey),
                  )
                ]
              ),
            );
          } else {
            return StaggeredGrid.count(
              crossAxisCount: screenWidth > 800 ? 2 : 1,
              crossAxisSpacing: 15,
              mainAxisSpacing: 13,
              children: [
                for (int i = 0; i < reviewsSnapshot.data.length; i++)
                  ReviewCard(reviewsSnapshot: reviewsSnapshot, index: i),
              ],
            );
          }
        }
      },
    );
  }
}

class ReviewCard extends StatelessWidget {
  final AsyncSnapshot reviewsSnapshot;
  final int index;

  const ReviewCard({Key? key, required this.reviewsSnapshot, required this.index}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    int rating = reviewsSnapshot.data![index].fields.score;
    String username = reviewsSnapshot.data![index].fields.username;
    String reviewDescription = reviewsSnapshot.data![index].fields.reviewDescription;
    String date = reviewsSnapshot.data![index].fields.date.toString().substring(0, 10);

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