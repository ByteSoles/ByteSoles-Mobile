import 'package:bytesoles/catalog/models/sneaker.dart';
import 'package:bytesoles/review/models/review_entry.dart';
import 'package:bytesoles/review/screens/review_page.dart';
import 'package:bytesoles/review/widgets/review_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ShoeCard extends StatelessWidget {
  final Sneaker sneaker;
  final String rating;
  final String? username;
  final int? userId;

  const ShoeCard({Key? key, required this.sneaker, required this.rating, required this.username, required this.userId}) : super(key: key);

  Future<List<ReviewEntry>> getUserReview(CookieRequest request, String? username, int sneakerId) async {
    if (username == null) {
      return [];
    }
    final response = await request.get('http://127.0.0.1:8000/review/$sneakerId/$username/');
    var data = response;

    List<ReviewEntry> review = [];
    for (var d in data) {
      if (d != null) {
        review.add(ReviewEntry.fromJson(d));
      }
    }
    return review;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final request = context.watch<CookieRequest>();
    int score = 5;

    return Card(
      elevation: 4,
      child: Container(
        height: screenWidth >= 1200 ? 250 : screenWidth > 800 ? 800 * 0.55 : screenWidth * 0.55,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
          child: Flex(
            direction: screenWidth >= 1200 ? Axis.horizontal : Axis.vertical,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: screenWidth >= 1200 ? MainAxisAlignment.start : MainAxisAlignment.center,
                  children: [
                    SizedBox(width: screenWidth * 0.017),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        sneaker.fields.image,
                        fit: BoxFit.fill,
                        width: screenWidth > 900 ? 900 * 0.25 : screenWidth * 0.25,
                      )
                    ),
                    SizedBox(width: screenWidth * 0.012),
                    Container(
                      width: screenWidth >= 1200 ? screenWidth * 0.18 : screenWidth * 0.33,
                      child: Text(
                        sneaker.fields.name,
                        style: TextStyle(
                          fontSize: screenWidth > 800 ? 19 : 17,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      )
                    )
                  ],
                )
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_rounded, 
                          color: Colors.yellow[600],
                          size: screenWidth > 800 ? 40 : 30,
                        ),
                        SizedBox(width: screenWidth * 0.004),
                        Text(
                          rating,
                          style: TextStyle(
                            fontSize: screenWidth >= 1200 ? 24 : screenWidth > 800 ? 22 : 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.015),
                    FutureBuilder(
                      future: getUserReview(request, username, sneaker.pk),
                      builder: (context, AsyncSnapshot reviewSnapshot) {
                        if (reviewSnapshot.hasData && reviewSnapshot.data != null && reviewSnapshot.data.isNotEmpty) {
                          score = reviewSnapshot.data[0].fields.score;
                        }
                        return username != null 
                          ? Container(
                              width: screenWidth >= 1200 ? screenWidth * 0.25 : screenWidth > 1000 ? 1000 * 0.3 : screenWidth * 0.3,
                              height: 40,
                              child: (!reviewSnapshot.hasData || reviewSnapshot.data == null || reviewSnapshot.data.isEmpty)
                                ? ElevatedButton(
                                    onPressed: () => addReview(context, score, sneaker, username!, userId!),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.black,
                                    ),
                                    child: Text(
                                      "Add Review",
                                      style: TextStyle(
                                        fontSize: screenWidth > 800 ? 17 : 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                  )
                                : ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        final request = context.read<CookieRequest>();
                                        final response = await request.post(
                                          "http://localhost:8000/review/delete-review-flutter/",
                                          {
                                            'user_id': userId.toString(),
                                            'sneaker_id': sneaker.pk.toString(),
                                          },
                                        );

                                        if (response['status'] == 'success') {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => ReviewPage(sneaker: sneaker)),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(response['message'] ?? 'Failed to delete review'))
                                          );
                                        }
                                      } catch (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Error: $e'))
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                    child: Text(
                                      "Delete Review",
                                      style: TextStyle(
                                        fontSize: screenWidth > 800 ? 17 : 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                  )
                            )
                          : 
                          Text(
                              screenWidth > 800 ? 'Take a moment to look around and see what others think about this sneaker. Reading their reviews can help you make the perfect choice! (Login to leave your own review)' :  'Login to leave your own review',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            );
                      }
                    )
                  ],
                )
              ),
            ],
          ),
        )
      ),
    );
  }
}