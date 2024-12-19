import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_theme.dart';
import '../app_utils.dart';

enum BottomBarEnum {
  home,
  wishlist,
  search, 
  setting
}

class CustomBottomBar extends StatefulWidget {
  final Function(BottomBarEnum)? onChanged;

  CustomBottomBar({this.onChanged});

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;
  final theme = ThemeHelper.themeData();

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNavHome,
      activeIcon: ImageConstant.imgNavHome,
      title: "Home",
      type: BottomBarEnum.home,
      isCircle: true,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavWishlist,
      activeIcon: ImageConstant.imgNavWishlist,
      title: "Wishlist",
      type: BottomBarEnum.wishlist,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavSearch,
      activeIcon: ImageConstant.imgNavSearch,
      title: "Search",
      type: BottomBarEnum.search,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavSetting,
      activeIcon: ImageConstant.imgNavSetting,
      title: "Setting",
      type: BottomBarEnum.setting,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 24.h,
        right: 26.h,
        bottom: 10.h,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          if (bottomMenuList[index].isCircle) {
            return BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {},
                constraints: BoxConstraints(
                  minHeight: 60.h,
                  minWidth: 60.h,
                ),
                padding: EdgeInsets.all(0),
                icon: Container(
                  width: 60.h,
                  height: 64.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onError,
                    borderRadius: BorderRadius.circular(30.h),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.09),
                        spreadRadius: 2.h,
                        blurRadius: 2.h,
                        offset: Offset(0, 2.29),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(16.h),
                  child: SvgPicture.asset(
                    bottomMenuList[index].icon,
                  ),
                ),
              ),
              label: '',
            );
          }
          return BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 26.h,
                  width: 26.h,
                  child: SvgPicture.asset(
                    bottomMenuList[index].icon,
                    color: Color(0XFF000000),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  bottomMenuList[index].title ?? "",
                  style: CustomTextStyles.labelLargeRobotoPrimary.copyWith(
                    color: Color(0XFF000000),
                  ),
                )
              ],
            ),
            activeIcon: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 26.h,
                    width: 26.h,
                    child: SvgPicture.asset(
                      bottomMenuList[index].activeIcon,
                      color: Color(0XFF000000),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    bottomMenuList[index].title ?? "",
                    style: CustomTextStyles.bodyMediumRobotoPrimary.copyWith(
                      color: Color(0XFF000000),
                    ),
                  )
                ],
              ),
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

class BottomMenuModel {
  final String icon;
  final String activeIcon;
  final String? title;
  final BottomBarEnum type;
  final bool isCircle;

  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
    this.isCircle = false,
  });
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageConstant {
  // Private constructor untuk mencegah instantiasi
  ImageConstant._();
  
  static const String imgNavHome = "assets/images/img_nav_home.svg";
  static const String imgNavWishlist = "assets/images/img_nav_wishlist.svg";
  static const String imgNavSearch = "assets/images/img_nav_search.svg";
  static const String imgNavSetting = "assets/images/img_nav_setting.svg";
}
