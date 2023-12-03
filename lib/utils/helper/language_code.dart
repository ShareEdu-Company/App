import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../router/router.dart';

class LanguageHelper {
  static int getLanguageCode(BuildContext context) {
    return RoutesHelper.navigatorKey.currentContext!.locale.toString() == 'ar'
        ? 2
        : 1;
  }
}
