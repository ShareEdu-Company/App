// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:almaraqischool/data/local_database/local_database.dart';
import 'package:almaraqischool/screens/starting/starting_screen.dart';
import '../models/login_model.dart';

class AuthServices {
  static Future<int?> login(
    LoginModel loginParameters,
  ) async {
    const String baseUrl = "https://almaraqi-schools.com/";
    final Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: true,
        ),
      );
    }
    try {
      final res = await dio.request(
        "grand/shareedulogin/UserloginSendNewMob.asp",
        queryParameters: loginParameters.toJson(),
        options: Options(method: "POST"),
      );
      int? userIndex = int.tryParse(res.data);
      return (userIndex);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static void logout(BuildContext context) {
    LocalDatabase.deletUserData();
    Navigator.of(context).pushNamedAndRemoveUntil(
      StartingScreen.routeName,
      (route) => false,
    );
  }
}
