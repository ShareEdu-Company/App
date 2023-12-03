import 'package:flutter/material.dart';
import 'package:almaraqischool/shared/logo.dart';
import 'package:almaraqischool/utils/constants/syles.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "/splash";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const LogoWidget(),
        ),
      ),
    );
  }
}
