// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:almaraqischool/data/models/login_model.dart';
import 'package:almaraqischool/screens/web_view_screen/web_view_screen.dart';
import 'package:almaraqischool/shared/top_loader.dart';
import 'package:almaraqischool/utils/constants/urls.dart';
import 'package:almaraqischool/utils/helper/language_code.dart';
import 'package:almaraqischool/utils/translations/locale_keys.g.dart';
import '../../../data/web_services/auth_services.dart';
import '../../data/local_database/local_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../utils/router/router.dart';

final loginProvider = ChangeNotifierProvider<LoginProvider>(
  (ref) => LoginProvider(ref),
);

class LoginProvider extends ChangeNotifier {
  final Ref _ref;
  LoginProvider(this._ref);

  int _id = 0;
  void setId(String id) {
    _id = int.parse(id);
  }

  String _pass = "";
  void setPass(String pass) {
    _pass = pass.trim();
  }

  final formKey = GlobalKey<FormState>();
  Future<void> onLoginPressed(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    TopLoader.startLoading(context);
    String? token = await FirebaseMessaging.instance.getToken();
    final int? userIndex = await _login(token, context);
    TopLoader.stopLoading(context);

    if (userIndex == null || token == null) {
      _showErrorMessage(LocaleKeys.loginError.tr(), context);
      return;
    }
    if (userIndex == 0) {
      _showErrorMessage(LocaleKeys.loginAuthError.tr(), context);
      return;
    }

    _saveUserDataToDatabse(userIndex, token);
    _reDirectUserToHomeScreen(userIndex, context);
  }

  Future<int?> _login(String? token, BuildContext context) async {
    final LoginModel loginModel = LoginModel(
      tokenId: token ?? "",
      operSys: Platform.isAndroid ? "android" : "ios",
      tuserName: _id,
      tuserPassword: _pass,
      userType: _ref.read(userTypeProvider.notifier).state.index + 1,
      userLang: LanguageHelper.getLanguageCode(context),
    );
    final int? userIndex = await AuthServices.login(loginModel);
    return userIndex;
  }

  void _saveUserDataToDatabse(int userIndex, String token) {
    LocalDatabase.saveUserIndex(userIndex);
    LocalDatabase.saveUserToken(token);
  }

  void _reDirectUserToHomeScreen(int userIndex, BuildContext context) {
    switch (userIndex) {
      case 1:
        Navigator.of(context).pushNamedAndRemoveUntil(
          WebViewScreen.routeName,
          (route) => false,
          arguments: {
            "pageUrl": AppUrls.employeePage,
            //  AppUrls.employeePage,
            "title": LocaleKeys.staffServices.tr(),
          },
        );
        break;
      case 4:
        _ref.read(userTypeProvider.notifier).state = UserType.trackedEmployee;

        Navigator.of(context).pushNamedAndRemoveUntil(
          WebViewScreen.routeName,
          (route) => false,
          arguments: {
            "pageUrl": AppUrls.employeePage,
            "title": LocaleKeys.staffServices.tr(),
          },
        );
        break;
      case 2:
        Navigator.of(context).pushNamedAndRemoveUntil(
          WebViewScreen.routeName,
          (route) => false,
          arguments: {
            "pageUrl": AppUrls.studentPage,
            "title": LocaleKeys.studentServices.tr(),
          },
        );
        break;
      case 3:
        Navigator.of(context).pushNamedAndRemoveUntil(
          WebViewScreen.routeName,
          (route) => false,
          arguments: {
            "pageUrl": AppUrls.parentPage,
            "title": LocaleKeys.parentServices.tr(),
          },
        );
        break;
    }
  }

  void _showErrorMessage(String errorMessage, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black54,
      ),
    );
  }
}

enum UserType { employee, student, parent, trackedEmployee }

final userTypeProvider = StateProvider<UserType>((ref) => UserType.employee);
