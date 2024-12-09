import 'package:flutter/material.dart';

/// Custom TextStyles untuk aplikasi
class CustomTextStyles {
  
    static TextStyle get bodySmallGray700 => TextStyle(
    color: Colors.grey[700],
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
  );
  static TextStyle get bodyMediumRobotoPrimary => TextStyle(
        color: ColorSchemes.lightCodeColorScheme.primary,
        fontSize: 14,
        fontFamily: 'Roboto',
      );

  static TextStyle get labelLargeRobotoPrimary => TextStyle(
        color: ColorSchemes.lightCodeColorScheme.primary,
        fontSize: 12,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
      );

  static TextStyle get displayMediumPrimary => TextStyle(
        color: ColorSchemes.lightCodeColorScheme.primary,
        fontSize: 40,
        fontFamily: 'Madimi One',
        fontWeight: FontWeight.w400,
      );
}

/// Class untuk menyimpan tema aplikasi
class ThemeHelper {
  static ThemeData themeData() => ThemeData(
        visualDensity: VisualDensity.standard,
        colorScheme: ColorSchemes.lightCodeColorScheme,
        textTheme: TextThemes.textTheme(ColorSchemes.lightCodeColorScheme),
      );

  static LightCodeColors themeColor() => LightCodeColors();
}

/// Class berisi tema teks yang didukung
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: colorScheme.primaryContainer,
          fontSize: 18,
          fontFamily: 'Madimi One',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: LightCodeColors.blueGray300,
          fontSize: 13,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: colorScheme.primary,
          fontSize: 12,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          color: colorScheme.onError,
          fontSize: 40,
          fontFamily: 'Madimi One',
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          color: colorScheme.primary,
          fontSize: 36,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          color: colorScheme.primary,
          fontSize: 24,
          fontFamily: 'Madimi One',
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: LightCodeColors.gray700,
          fontSize: 12,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onError,
          fontSize: 20,
          fontFamily: 'Madimi One',
          fontWeight: FontWeight.w400,
        ),
        titleMedium: TextStyle(
          color: colorScheme.primary,
          fontSize: 18,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: colorScheme.primary,
          fontSize: 15,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
      );
}

/// Class berisi skema warna yang didukung
class ColorSchemes {
  static const ColorScheme lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFF000000),
    primaryContainer: Color(0XFF161616),
    secondaryContainer: Color(0XFF575757),
    errorContainer: Color(0XFFECB30F),
    onError: Color(0XFFFFFFFF),
    onErrorContainer: Color(0X3317223B),
    onPrimary: Color(0XFF323232),
    onPrimaryContainer: Color(0XFF828282),
    onSecondaryContainer: Color(0XFF111010),
  );
}

/// Class berisi warna kustom untuk tema lightCode
class LightCodeColors {
  static Color get blueGray300 => const Color(0XFFA4A9B3);
  static Color get deepOrange500 => const Color(0XFFFF4B26);
  static Color get gray100 => const Color(0XFFF3F3F3);
  static Color get gray10001 => const Color(0XFFF2F2F2);
  static Color get gray300 => const Color(0XFFDEDBDB);
  static Color get gray400 => const Color(0XFFC4C4C4);
  static Color get gray40001 => const Color(0XFFBBBBBB);
  static Color get gray500 => const Color(0XFFA0A0A1);
  static Color get gray50001 => const Color(0XFFA8A8A9);
  static Color get gray700 => const Color(0XFF676767);
  static Color get gray70001 => const Color(0XFF616161);
  static Color get gray900 => const Color(0XFF232327);
  static Color get redA200 => const Color(0XFFF73658);
  static Color get whiteA700 => const Color(0XFFFDFDFD);
}

/// Class berisi dekorasi aplikasi
class AppDecoration {
  static BoxDecoration get fillOnError => BoxDecoration(
        color: ColorSchemes.lightCodeColorScheme.onError,
      );

  static BoxDecoration get fillPrimary => BoxDecoration(
        color: ColorSchemes.lightCodeColorScheme.primary,
      );

  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: LightCodeColors.whiteA700,
      );

  static BoxDecoration get gradientGrayToGray => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.49, 0.51),
          end: const Alignment(0.49, 1.48),
          colors: [
            LightCodeColors.gray40001,
            LightCodeColors.gray40001.withOpacity(0),
          ],
        ),
      );

  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: ColorSchemes.lightCodeColorScheme.onError,
        boxShadow: [
          BoxShadow(
            color: ColorSchemes.lightCodeColorScheme.primary.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      );
}

/// Class berisi gaya border radius
class BorderRadiusStyle {
  static BorderRadius get circleBorder20 => BorderRadius.circular(20);
  static BorderRadius get roundedBorder10 => BorderRadius.circular(10);
  static BorderRadius get roundedBorder16 => BorderRadius.circular(16);
  static BorderRadius get roundedBorder24 => BorderRadius.circular(24);
}


