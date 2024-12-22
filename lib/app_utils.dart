import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final Map<String, String> enUs = {
  "lbl_bytesoles": "ByteSoles",
  "lbl_1": "1",
  "lbl_1_3": "1/3",
  "lbl_3": "/3",
  "lbl_choose_products": "Choose Products",
  "lbl_2_3": "2/3",
  "lbl_make_payment": "Make Payment",
  "lbl_3_3": "3/3",
  "lbl_get_your_order": "Get Your Order",
  "lbl_sign_up": "Sign Up",
  "lbl_welcome_back": "Welcome \nBack!",
  "msg_create_an_account": "Create An Account",
  "msg_forgot_password": "Forgot Password?",
  "lbl_by_clicking_the": "By clicking the ",
  "lbl_confirmpassword": "ConfirmPassword",
  "lbl_create_account": "Create Account",
  "msg_by_clicking_the":
      "By clicking the Register button, you agree to the public offer",
  "msg_create_an_account2": "Create an \naccount",
  "msg_i_already_have_an": "I Already Have an Account",
  "msg_register_button": "Register button, you agree to the public offer",
  "lbl_cart": "Cart",
  "lbl_catalog": "Catalog",
  "lbl_hello_user": "Hello, User!",
  "lbl_wishlist": "Wishlist",
  "lbl_100_items": "100+ Items ",
  "lbl_filter": "Filter",
  "lbl_sort": "Sort",
  "msg_nike_air_force_1": "Nike Air Force 1 Low '07 Black Black",
  "lbl_100": "\$100",
  "lbl_6_890": "6,890",
  "lbl_add_to_cart": "Add To Cart",
  "lbl_add_to_wishlist": "Add To Wishlist",
  "lbl_bytesoles2": "Bytesoles",
  "lbl_home": "Home",
  "lbl_login": "Login",
  "lbl_next": "Next",
  "lbl_password": "Password",
  "lbl_reviews": "Reviews",
  "lbl_search": "Search",
  "lbl_setting": "Setting",
  "lbl_skip": "Skip",
  "lbl_wishlist2": "wishlist",
  "msg_amet_minim_mollit":
      "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
  "msg_nike_air_force_12":
      "Nike Air Force 1 LowNike Air Force 1 Low '07 Black Black'07 Black Black",
  "msg_username_or_email": "Username or Email",
  "err_msg_field_cannot_be_empty": "Field cannot be empty",
  "err_msg_please_enter_valid_email": "Please enter valid email",
  "err_msg_please_enter_valid_password": "Please enter valid password",
  "msg_network_err": "Network Error",
  "msg_something_went_wrong": "Something Went Wrong!"
};

const num figmaDesignWidth = 430;
const num figmaDesignHeight = 932;
const num figmaDesignStatusBar = 0;
const String dateTimeFormatPattern = 'dd/MM/yyyy';

bool isValidEmail(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;
  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }
  if (inputString != null && inputString.isNotEmpty) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }
  return isInputStringValid;
}

bool isValidPassword(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;
  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }
  if (inputString != null && inputString.isNotEmpty) {
    const pattern =
        r'^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }
  return isInputStringValid;
}

extension ResponsiveExtension on num {
  double get _width => SizeUtils.width;
  double get h => ((this * _width) / figmaDesignWidth);
  double get fSize => ((this * _width) / figmaDesignWidth);
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(this.toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

extension DateTimeExtension on DateTime {
  String format({
    String pattern = dateTimeFormatPattern,
    String? locale,
  }) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}

enum DeviceType { mobile, tablet, desktop }

typedef ResponsiveBuild = Widget Function(
    BuildContext context, Orientation orientation, DeviceType deviceType);

class ImageConstant {
  static String imagePath = 'assets/images';

  static String imgUnsplashNovnxxmdni0 =
      '$imagePath/img_unsplash_novnxxmdni0.png';

  static String imgArrowRight = '$imagePath/img_arrow_right.svg';

  static String imgUnsplash76wEdo1u1e =
      '$imagePath/img_unsplash_76w_edo1u1e.png';

  static String imgArrowLeft = '$imagePath/img_arrow_left.svg';

  static String imgUnsplashMhuk4se7pey =
      '$imagePath/img_unsplash_mhuk4se7pey.png';

  static String imgUnsplashFur3lnii2jc =
      '$imagePath/img_unsplash_fur3lnii2jc.png';

  static String imgUnsplashEjtjetc8tps =
      '$imagePath/img_unsplash_ejtjetc8tps.png';

  static String imgSettings = '$imagePath/img_settings.svg';

  static String imgImage = '$imagePath/img_image.png';

  static String imgComponent1Gray900 =
      '$imagePath/img_component_1_gray_900.svg';

  static String imgComponent1Gray90016x16 =
      '$imagePath/img_component_1_gray_900_16x16.svg';

  static String imgImage152x178 = '$imagePath/img_image_152x178.png';

  static String imgComponent1Errorcontainer =
      '$imagePath/img_component_1_errorcontainer.svg';

  static String imgComponent1Gray40001 =
      '$imagePath/img_component_1_gray_400_01.svg';

  static String imgUser = '$imagePath/img_user.svg';

  static String imgTrophy = '$imagePath/img_trophy.svg';

  static String imgEye = '$imagePath/img_eye.svg';

  static String imgComponent1 = '$imagePath/img_component_1.svg';

  static String img2289Skvnqsbgqu1pidewmjgtmte2 =
      '$imagePath/img_2289_skvnqsbgqu1pidewmjgtmte2.png';

  static String imgImage256x362 = '$imagePath/img_image_256x362.png';

  static String imgNavHome = '$imagePath/img_nav_home.svg';

  static String imgNavWishlist = '$imagePath/img_nav_wishlist.svg';

  static String imgShoppingCart2 = '$imagePath/img_shopping_cart_2.svg';

  static String imgNavSearch = '$imagePath/img_nav_search.svg';
  static String imgNavSetting = '$imagePath/img_nav_setting.svg';

  static String imageNotFound = 'assets/images/image_not_found.png';
}

class Sizer extends StatelessWidget {
  const Sizer({Key? key, required this.builder}) : super(key: key);

  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeUtils.setScreenSize(constraints, orientation);
        return builder(context, orientation, SizeUtils.deviceType);
      });
    });
  }
}

class SizeUtils {
  static late BoxConstraints boxConstraints;

  static late Orientation orientation;

  static late DeviceType deviceType;

  static late double height;

  static late double width;

  static void setScreenSize(
    BoxConstraints constraints,
    Orientation currentOrientation,
  ) {
    boxConstraints = constraints;
    orientation = currentOrientation;
    if (orientation == Orientation.portrait) {
      width =
          boxConstraints.maxWidth.isNonZero(defaultValue: figmaDesignWidth);
      height = boxConstraints.maxHeight.isNonZero();
    } else {
      width =
          boxConstraints.maxHeight.isNonZero(defaultValue: figmaDesignWidth);
      height = boxConstraints.maxWidth.isNonZero();
    }
    deviceType = DeviceType.mobile;
  }
}