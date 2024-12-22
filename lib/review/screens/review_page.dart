import 'package:bytesoles/catalog/models/sneaker.dart';
import 'package:bytesoles/review/widgets/bottom_navigation_bar.dart';
import 'package:bytesoles/routes/app_routes.dart';
import 'package:bytesoles/userprofile/screens/profile_screen.dart';
import 'package:bytesoles/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:bytesoles/review/widgets/shoe_card.dart';
import 'package:bytesoles/review/widgets/review_list.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  final Sneaker sneaker;

  const ReviewPage({Key? key, required this.sneaker}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  String? username;

  @override
  void initState() {
    super.initState();
    final request = context.read<CookieRequest>();
    if (request.loggedIn) {
      print('Fetching username');
      setState(() {
        username = request.jsonData['username'];
      });
    }
  }

  Future<String> fetchRating(CookieRequest request) async {
    final response = await request.get('http://127.0.0.1:8000/review/rating/${widget.sneaker.fields.slug}/');
    String rating = response.toStringAsFixed(1);
    return rating;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Sneaker sneaker = widget.sneaker;
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: CustomHeader(
        isLoggedIn: context.read<CookieRequest>().loggedIn,
        onMenuPressed: () => Scaffold.of(context).openDrawer(),
        onLoginPressed: () {
          if (context.read<CookieRequest>().loggedIn) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            } else {
              Navigator.pushNamed(context, AppRoutes.login);
            }
        },
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, left: screenWidth * 0.14, right: screenWidth * 0.14),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reviews',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]
                    )
                  ),
                  FutureBuilder(
                    future: fetchRating(request),
                    builder: (context, AsyncSnapshot ratingSnapshot) {
                      if (ratingSnapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator()
                        );
                      } else {
                        return ShoeCard(
                          sneaker: sneaker,
                          rating: ratingSnapshot.data.toString(),
                          username: username,
                        );
                      }
                    }
                  ),
                  SizedBox(height: 25),
                  ReviewList(slug: sneaker.fields.slug, username: username),
                ]
              )
            )
          );
        }
      ),
    );
  }
}