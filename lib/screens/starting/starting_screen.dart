import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:almaraqischool/screens/guest/guest_screen.dart';
import 'package:almaraqischool/screens/language/language_provider.dart';
import 'package:almaraqischool/screens/login/login_screen.dart';
import 'package:almaraqischool/shared/logo.dart';
import 'package:almaraqischool/utils/constants/syles.dart';
import '../../shared/button_widget.dart';
import '../../utils/translations/locale_keys.g.dart';

class StartingScreen extends StatelessWidget {
  static const routeName = "/starting";
  const StartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              SizedBox(height: 0.2 * size.height),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: const LogoWidget(),
              ),
              const SizedBox(height: 60),
              ButtonWidget(
                width: double.infinity,
                title: LocaleKeys.login.tr(),
                onButtonPressed: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
              ),
              const SizedBox(height: 15),
              ButtonWidget(
                width: double.infinity,
                title: LocaleKeys.guestRegister.tr(),
                onButtonPressed: () {
                  Navigator.of(context).pushNamed(GuestScreen.routeName);
                },
              ),
              const SizedBox(height: 15),
              Consumer(builder: (context, ref, _) {
                return ButtonWidget(
                  width: double.infinity,
                  title: LocaleKeys.language.tr(),
                  onButtonPressed: () {
                    ref
                        .read(changeLangProvider)
                        .onChangeLangPressed(context, ref);
                  },
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: const LogoWidget2(),
        ),
      ),
    );
  }
}
