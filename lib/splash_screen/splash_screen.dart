import '../app_utils.dart';
// import '../routes/app_routes.dart';
// import '../widgets.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(38.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildBytesolesColumn(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBytesolesColumn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 4.h),
      child: Column(
        children: [
          Text(
            "ByteSoles",
            style: CustomTextStyles.displayMediumPrimary,
          )
        ],
      ),
    );
  }
}
