import 'package:flutter/material.dart';
import 'package:almaraqischool/utils/constants/syles.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onButtonPressed;
  final Color color;
  final Color textColor;
  final TextStyle textStyle;
  final double borderRadius;
  final double? width;
  final double? hight;
  final double elevation;
  final Widget? icon;
  const ButtonWidget({
    Key? key,
    required this.title,
    required this.onButtonPressed,
    this.color = AppStyles.primaryColor,
    this.borderRadius = 10,
    this.width = 110,
    this.hight = 46,
    this.elevation = 2,
    this.textStyle = AppStyles.textStyleBoldWhite16,
    this.textColor = Colors.white,
    this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: hight,
      child: ElevatedButton.icon(
        icon: icon ?? Container(),
        label: Text(
          title,
          style: AppStyles.textStyleReg16.copyWith(fontFamily: 'Cairo'),
        ),
        onPressed: onButtonPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          alignment: Alignment.center,
          backgroundColor: color,
          elevation: elevation,
          textStyle: textStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
