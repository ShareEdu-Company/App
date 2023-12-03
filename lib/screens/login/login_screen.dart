import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:almaraqischool/screens/login/components/login_form.dart';
import 'package:almaraqischool/shared/app_bar_widget.dart';
import 'package:almaraqischool/shared/logo.dart';
import 'package:almaraqischool/utils/translations/locale_keys.g.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: LocaleKeys.login.tr(),
        hasTrackingButton: false,
        hasBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const LogoWidget(),
              ),
              const SizedBox(height: 60),
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
