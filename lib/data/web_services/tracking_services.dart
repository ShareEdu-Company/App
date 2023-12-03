// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:almaraqischool/data/models/tracking_model.dart';

class TrackingServices {
  static Future<void> sendLocation(TrackingModel trackingModel) async {
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
      await dio.request(
        "MobileServices2022/indexEmpTrack.asp",
        queryParameters: trackingModel.toJson(),
        options: Options(method: "POST"),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
