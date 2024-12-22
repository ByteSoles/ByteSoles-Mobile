import 'package:flutter/material.dart';
// import '../app_theme.dart';
import '../app_utils.dart';
// import '../routes/app_routes.dart';
// import '../widgets.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0XFFFFFFFF),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Text(
                        "App Navigation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 20.fSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.h),
                      child: Text(
                        "Check your app's UI from the below demo screens of your app.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0XFF888888),
                          fontSize: 16.fSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Divider(
                      height: 1.h,
                      thickness: 1.h,
                      color: Color(0XFF000000),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFFFFFFF),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                child: Text(
                                  "Splash Screen",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0XFF000000),
                                    fontSize: 20.fSize,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(height: 5.h),
                              Divider(
                                height: 1.h,
                                thickness: 1.h,
                                color: Color(0XFF888888),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFFFFFFF),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                child: Text(
                                  "Splash Screen One",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0XFF000000),
                                    fontSize: 20.fSize,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(height: 5.h),
                              Divider(
                                height: 1.h,
                                thickness: 1.h,
                                color: Color(0XFF888888),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFFFFFFF),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                child: Text(
                                  "Splash Screen Two",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0XFF000000),
                                    fontSize: 20.fSize,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(height: 5.h),
                              Divider(
                                height: 1.h,
                                thickness: 1.h,
                                color: Color(0XFF888888),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFFFFFFF),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                child: Text(
                                  "Splash Screen Three",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0XFF000000),
                                    fontSize: 20.fSize,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(height: 5.h),
                              Divider(
                                height: 1.h,
                                thickness: 1.h,
                                color: Color(0XFF888888),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFFFFFFF),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                child: Text(
                                  "Sign In",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0XFF000000),
                                    fontSize: 20.fSize,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(height: 5.h),
                              Divider(
                                height: 1.h,
                                thickness: 1.h,
                                color: Color(0XFF888888),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFFFFFFF),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                child: Text(
                                  "Sign Up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0XFF000000),
                                    fontSize: 20.fSize,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(height: 5.h),
                              Divider(
                                height: 1.h,
                                thickness: 1.h,
                                color: Color(0XFF888888),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFFFFFFF),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                child: Text(
                                  "HomeScreen",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0XFF000000),
                                    fontSize: 20.fSize,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(height: 5.h),
                              Divider(
                                height: 1.h,
                                thickness: 1.h,
                                color: Color(0XFF888888),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFFFFFFF),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 5.h),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                child: Text(
                                  "Catalog Products",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0XFF000000),
                                    fontSize: 20.fSize,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(height: 5.h),
                              Divider(
                                height: 1.h,
                                thickness: 1.h,
                                color: Color(0XFF888888),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFFFFFFF),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                child: Text(
                                  "Detail Product",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0XFF000000),
                                    fontSize: 20.fSize,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(height: 5.h),
                              Divider(
                                height: 1.h,
                                thickness: 1.h,
                                color: Color(0XFF888888),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


