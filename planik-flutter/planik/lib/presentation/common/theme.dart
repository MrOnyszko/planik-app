// ignore_for_file: overridden_fields

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planik/presentation/common/extensions.dart';

class _AppColors {
  _AppColors._();

  static const Color greenColor = Color(0xff44cc66);
  static const Color redColor = Color(0xffda7b7b);
  static const Color grayColor = Color(0xffd9d9d9);
  static const Color mainColor = Color(0xFF303F9F);
  static const Color mainLighterColor = Color(0xFF7986CB);
  static const Color dirtyWhiteColor = Color(0xfff0f0f0);
  static const Color lightGrayColor = Color(0xffa2a2a2);
  static const Color darkGrayColor = Color(0xff5f5f5f);
  static const Color almostBlackColor = Color(0xff2d2d2d);
}

abstract class Palette {
  late Brightness brightness;
  late Color accentColor;
  late Color answerAgainColor;
  late Color answerGoodColor;
  late Color answerHardColor;
  late Color answerPositiveColor;
  late Color answerNegativeColor;
  late Color answerNeutralColor;
  late Color appBarBackgroundColor;
  late Color borderColor;
  late Color cardColor;
  late Color errorColor;
  late Color iconColor;
  late Color inactiveColor;
  late Color primaryColor;
  late Color primaryDarkColor;
  late Color primaryLightColor;
  late Color primaryLighterColor;
  late Color primaryTextBodyColor;
  late Color primaryTextDisplayColor;
  late Color scaffoldBackgroundColor;
  late Color textBodyColor;
  late Color textDisplayColor;
  late Color textOnPrimaryColor;
  late Color whiteColor;
}

class LightPalette extends Palette {
  @override
  final Brightness brightness = Brightness.light;
  @override
  final Color accentColor = _AppColors.mainLighterColor;
  @override
  final Color answerAgainColor = _AppColors.redColor;
  @override
  final Color answerGoodColor = _AppColors.greenColor;
  @override
  final Color answerHardColor = _AppColors.grayColor;

  @override
  final Color answerPositiveColor = _AppColors.greenColor;
  @override
  final Color answerNegativeColor = _AppColors.redColor;
  @override
  final Color answerNeutralColor = _AppColors.grayColor;

  @override
  final Color appBarBackgroundColor = Colors.grey.shade50;
  @override
  final Color borderColor = _AppColors.lightGrayColor.withOpacity(0.2);
  @override
  final Color cardColor = const Color(0xffffffff);
  @override
  final Color errorColor = const Color(0xffcc4466);
  @override
  final Color iconColor = Colors.black;
  @override
  final Color inactiveColor = Colors.grey[100]!;
  @override
  final Color primaryColor = _AppColors.mainColor;
  @override
  final Color primaryDarkColor = _AppColors.mainColor; // todo: update
  @override
  final Color primaryLightColor = _AppColors.mainLighterColor;
  @override
  final Color primaryLighterColor = _AppColors.mainLighterColor.withOpacity(0.8);
  @override
  final Color primaryTextBodyColor = _AppColors.almostBlackColor;
  @override
  final Color primaryTextDisplayColor = _AppColors.darkGrayColor;
  @override
  final Color scaffoldBackgroundColor = const Color(0xffffffff);
  @override
  final Color textBodyColor = _AppColors.darkGrayColor;
  @override
  final Color textDisplayColor = _AppColors.lightGrayColor;
  @override
  final Color textOnPrimaryColor = _AppColors.dirtyWhiteColor;
  @override
  final Color whiteColor = _AppColors.dirtyWhiteColor;
}

class DarkPalette extends Palette {
  @override
  final Brightness brightness = Brightness.dark;
  @override
  final Color accentColor = _AppColors.mainLighterColor;
  @override
  final Color answerAgainColor = _AppColors.redColor;
  @override
  final Color answerGoodColor = _AppColors.greenColor;
  @override
  final Color answerHardColor = _AppColors.grayColor;
  @override
  final Color answerPositiveColor = _AppColors.greenColor;
  @override
  final Color answerNegativeColor = _AppColors.redColor;
  @override
  final Color answerNeutralColor = _AppColors.grayColor;
  @override
  final Color appBarBackgroundColor = _AppColors.almostBlackColor;
  @override
  final Color borderColor = _AppColors.darkGrayColor;
  @override
  final Color cardColor = _AppColors.almostBlackColor;
  @override
  final Color errorColor = const Color(0xffcc4466);
  @override
  final Color iconColor = _AppColors.dirtyWhiteColor;
  @override
  final Color inactiveColor = _AppColors.darkGrayColor.withOpacity(0.5);
  @override
  final Color primaryColor = _AppColors.almostBlackColor;
  @override
  final Color primaryDarkColor = Colors.black;
  @override
  final Color primaryLightColor = _AppColors.darkGrayColor;
  @override
  final Color primaryLighterColor = _AppColors.darkGrayColor.withOpacity(0.8);
  @override
  final Color primaryTextBodyColor = _AppColors.dirtyWhiteColor;
  @override
  final Color primaryTextDisplayColor = _AppColors.lightGrayColor;
  @override
  final Color scaffoldBackgroundColor = _AppColors.almostBlackColor;
  @override
  final Color textBodyColor = _AppColors.dirtyWhiteColor;
  @override
  final Color textDisplayColor = _AppColors.lightGrayColor;
  @override
  final Color textOnPrimaryColor = _AppColors.dirtyWhiteColor;
  @override
  final Color whiteColor = _AppColors.dirtyWhiteColor;
}

class AppTheme {
  static Palette paletteOf(BuildContext context) {
    if (context.theme.brightness == Brightness.light) {
      return LightPalette();
    } else if (context.theme.brightness == Brightness.dark) {
      return DarkPalette();
    } else {
      return LightPalette();
    }
  }

  ThemeData theme(Palette palette) {
    final theme = ThemeData(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: palette.accentColor,
        selectionColor: palette.accentColor,
        selectionHandleColor: palette.accentColor,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryTextTheme: _textThemeHandset.apply(
        bodyColor: palette.primaryTextBodyColor,
        displayColor: palette.primaryTextDisplayColor,
      ),
      textTheme: _textThemeHandset.apply(
        bodyColor: palette.textBodyColor,
        displayColor: palette.textDisplayColor,
      ),
      canvasColor: palette.scaffoldBackgroundColor,
      backgroundColor: palette.scaffoldBackgroundColor,
      scaffoldBackgroundColor: palette.scaffoldBackgroundColor,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: generateMaterialColor(palette.primaryColor),
        accentColor: palette.accentColor,
        brightness: palette.brightness,
      ),
    );
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarBrightness: palette.brightness,
          statusBarIconBrightness: palette.brightness,
          systemNavigationBarIconBrightness: palette.brightness,
        ),
        elevation: 0,
        color: palette.appBarBackgroundColor,
        iconTheme: IconThemeData(
          color: palette.iconColor,
        ),
        actionsIconTheme: IconThemeData(
          color: palette.iconColor,
        ),
        textTheme: _textThemeHandset,
      ),
      cardColor: palette.cardColor,
      colorScheme: theme.colorScheme.copyWith(
        error: palette.errorColor,
        background: palette.scaffoldBackgroundColor,
        surface: palette.scaffoldBackgroundColor,
      ),
      iconTheme: IconThemeData(
        color: palette.iconColor,
      ),
    );
  }

  TextTheme get _textThemeHandset {
    return TextTheme(
      headline1: GoogleFonts.ubuntu(
        fontSize: 98,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      headline2: GoogleFonts.ubuntu(
        fontSize: 61,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      headline3: GoogleFonts.ubuntu(
        fontSize: 49,
        fontWeight: FontWeight.w400,
      ),
      headline4: GoogleFonts.ubuntu(
        fontSize: 35,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headline5: GoogleFonts.ubuntu(
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      headline6: GoogleFonts.ubuntu(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      subtitle1: GoogleFonts.ubuntu(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      subtitle2: GoogleFonts.ubuntu(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyText1: GoogleFonts.ubuntu(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyText2: GoogleFonts.ubuntu(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      button: GoogleFonts.ubuntu(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      caption: GoogleFonts.ubuntu(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      overline: GoogleFonts.ubuntu(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    );
  }

  MaterialColor generateMaterialColor(Color color) => MaterialColor(color.value, {
        50: tintColor(color, 0.9),
        100: tintColor(color, 0.8),
        200: tintColor(color, 0.6),
        300: tintColor(color, 0.4),
        400: tintColor(color, 0.2),
        500: color,
        600: shadeColor(color, 0.1),
        700: shadeColor(color, 0.2),
        800: shadeColor(color, 0.3),
        900: shadeColor(color, 0.4),
      });

  int tintValue(int value, double factor) => max(
        0,
        min((value + ((255 - value) * factor)).round(), 255),
      );

  Color tintColor(Color color, double factor) => Color.fromRGBO(
        tintValue(color.red, factor),
        tintValue(color.green, factor),
        tintValue(color.blue, factor),
        1,
      );

  int shadeValue(int value, double factor) => max(
        0,
        min(value - (value * factor).round(), 255),
      );

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
        shadeValue(color.red, factor),
        shadeValue(color.green, factor),
        shadeValue(color.blue, factor),
        1,
      );
}
