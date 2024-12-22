import 'package:bytesoles/catalog/models/sneaker.dart';
import 'package:bytesoles/review/screens/review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

Future<void> addReview(BuildContext context, int initialScore, Sneaker sneaker, String username, int userId) async {
  double screenWidth = MediaQuery.of(context).size.width;
  final _formKey = GlobalKey<FormState>();
  final request = Provider.of<CookieRequest>(context, listen: false);
  int score = initialScore;
  String reviewDescription = '';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Submit a Review',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Container(
          width: screenWidth > 800 ? 600 : screenWidth * 0.4,
          height: screenWidth > 800 ? 650 : screenWidth * 0.45,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: score.toDouble(),
                  minRating: 1,
                  itemBuilder: (context, _) {
                    return Icon(
                      Icons.star_rounded,
                      color: Colors.yellow[600],
                      size: 20,
                    );
                  },
                  onRatingUpdate: (newScore) {
                    score = newScore.toInt();
                  },
                ),
                SizedBox(height: 25),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Write your review',
                        border: InputBorder.none,  // Removes the underline
                      ),
                      maxLines: null,  // Allows the text to wrap and create new lines
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your review.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        reviewDescription = value;
                      },
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.red,
            ),
            child: Text(
              "Cancel",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ),
          // Submit button
          ElevatedButton(
            onPressed: () async {
              try {
                final request = context.read<CookieRequest>();
                final response = await request.post(
                  "http://localhost:8000/review/add-review-ajax-flutter/",
                  {
                    'user_id': userId.toString(),
                    'username': username,
                    'sneaker_id': sneaker.pk.toString(),
                    'review_description': reviewDescription,
                    'score': score.toString(),
                  },
                );
                
                if (response['status'] == 'success') {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ReviewPage(sneaker: sneaker)),
                  );
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response['message'] ?? 'An error occurred'))
                  );
                }
              } catch (e) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e'))
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.black,
            ),
            child: Text(
              "Submit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          )
        ],
      );
    },
  );
}