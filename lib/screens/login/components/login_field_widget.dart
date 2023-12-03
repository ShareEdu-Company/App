import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:almaraqischool/utils/constants/syles.dart';

class LoginFieldWidget extends StatelessWidget {
  const LoginFieldWidget({
    Key? key,
    this.validator,
    required this.labelText,
    this.onSaving,
    this.controller,
    this.isLongField = false,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);
  final Function(String?)? validator;
  final Function(String?)? onSaving;
  final String labelText;
  final TextEditingController? controller;
  final bool isLongField;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AppStyles.textStyleSemiBoldPrim16.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: TextFormField(
            controller: controller,
            validator: (v) => validator == null ? null : validator!(v),
            onSaved: (v) => onSaving == null ? null : onSaving!(v),
            maxLines: isLongField ? 4 : 1,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              enabledBorder: AppStyles.outlineBorder,
              focusedBorder: AppStyles.outlineBorder,
              errorBorder: AppStyles.errorOutlineBorder,
              focusedErrorBorder: AppStyles.errorOutlineBorder,
            ),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
          ),
        ),
      ],
    );
  }
}
