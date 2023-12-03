import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:almaraqischool/data/local_database/local_database.dart';
import 'package:almaraqischool/data/models/tracking_model.dart';
import 'package:almaraqischool/data/web_services/tracking_services.dart';

class TrackingHelper {
  late final WidgetRef _ref;
  TrackingHelper(this._ref);

  void startTracking() {
    Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        _sendLocationToServer();
        if (!_ref.read(trackingProvider.notifier).state) {
          timer.cancel();
        }
      },
    );
  }

  Future<void> _sendLocationToServer() async {
    final Position? position = await _getLocation();
    if (position == null) {
      _ref.read(trackingProvider.notifier).state = false;
      return;
    }
    final trackingModel = TrackingModel(
      tokenId: LocalDatabase.getUserToken()!,
      operSys: Platform.isAndroid ? "android" : "ios",
      latVar: position.latitude,
      longVar: position.longitude,
    );
    TrackingServices.sendLocation(trackingModel);
  }

  static Future<Position?> _getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}

final trackingProvider = StateProvider.autoDispose<bool>((ref) => false);
