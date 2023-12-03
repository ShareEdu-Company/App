import 'package:flutter/material.dart';
import 'package:almaraqischool/utils/constants/syles.dart';

class TopLoader {
  static const SizedBox _container = SizedBox(
    width: 40,
    height: 40,
    child:
        Center(child: CircularProgressIndicator(color: AppStyles.primaryColor)),
  );

  static void startLoading(BuildContext context) {
    showDialog(
      barrierColor: Colors.black54,
      barrierDismissible: false,
      context: context,
      builder: (context) => _container,
    );
  }

  static void stopLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}
