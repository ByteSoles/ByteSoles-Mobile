import 'package:flutter/material.dart';

class ShoeCard extends StatelessWidget {
  const ShoeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                        "https://images.tokopedia.net/img/cache/500-square/VqbcmM/2023/2/10/30bae113-9ecb-48af-a313-a4736248a3f7.jpg",
                        fit: BoxFit.fill,
                        width: screenWidth > 900 ? 900 * 0.25 : screenWidth * 0.25,
                      )
                    ),
                    SizedBox(width: screenWidth * 0.012),
                    Container(
                      width: screenWidth >= 1200 ? screenWidth * 0.18 : screenWidth * 0.33,
                      child: Text(
                        "Nike Dunk Low Retro White Black Panda (2021) (Women's)",
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
                          "4.5",
                          style: TextStyle(
                            fontSize: screenWidth >= 1200 ? 24 : screenWidth > 800 ? 22 : 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.015),
                    Container(
                      width: screenWidth >= 1200 ? screenWidth * 0.23 : 1100 * 0.25,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.black,
                        ),
                        child: Text(
                          screenWidth.toString(),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      )
                    ),
                    SizedBox(height: 10),
                    if (screenWidth > 790)
                      Text(
                        "We appreciate your review!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
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