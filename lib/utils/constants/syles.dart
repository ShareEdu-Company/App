import 'package:flutter/material.dart';

class AppStyles {
  static const primaryColor = Color(0xFF0E4D68);
  static const backgroundColor = Color(0xFFFFFFFF);
  static const geryColor = Color(0xff707070);
  static const deepGeryColor = Color(0xff7A7D80);
  static const disabledButtonColor = Color.fromARGB(255, 165, 163, 163);
  static const greyLightColor = Color(0xFFF7F7F7);
  static const greenColor = Color(0xFF48BB78);

  static ThemeData appTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Cairo',
    primarySwatch: MaterialColor(
      0xFF1877F2,
      _primaryColorMap,
    ),
    scaffoldBackgroundColor: Colors.white,
  );
  static const textStyleReg16 = TextStyle(fontSize: 16);
  static const textStyleReg14 = TextStyle(fontSize: 14);

  static const textStyleBold18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );
  static const textStyleBoldWhite16 = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w800,
  );
  static const textStyleRegGrey14 = TextStyle(
    fontSize: 14,
    color: geryColor,
    fontWeight: FontWeight.w800,
  );
  static const textStyleSemiBold16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const textStyleSemiBoldPrim16 = TextStyle(
    fontFamily: 'Cairo',
    color: primaryColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static final Map<int, Color> _primaryColorMap = {
    50: primaryColor,
    100: primaryColor,
    200: primaryColor,
    300: primaryColor,
    400: primaryColor,
    500: primaryColor,
    600: primaryColor,
    700: primaryColor,
    800: primaryColor,
    900: primaryColor,
  };
  static final outlineBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xff0E4D68)),
    borderRadius: BorderRadius.circular(15),
  );
  static final errorOutlineBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red),
    borderRadius: BorderRadius.circular(10),
  );
}
