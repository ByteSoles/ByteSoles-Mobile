import 'package:bytesoles/review/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:bytesoles/review/widgets/shoe_card.dart';
import 'package:bytesoles/review/widgets/review_list.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool isLoggedIn = true;
  String sneakerName = 'Nike Air Max 90';
  String sneakerImage = "https://images.tokopedia.net/img/cache/500-square/VqbcmM/2023/2/10/30bae113-9ecb-48af-a313-a4736248a3f7.jpg";
  double averageRating = 4.5;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
                  ShoeCard(),
                  SizedBox(height: 25),
                  ReviewList(),
                ]
              )
            )
          );
        }
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}