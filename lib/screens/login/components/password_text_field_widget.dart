import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:almaraqischool/utils/translations/locale_keys.g.dart';
import '../../../utils/constants/syles.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  const PasswordTextFieldWidget({
    Key? key,
    this.onSaving,
    required this.validator,
    this.controller,
    this.lableText,
  }) : super(key: key);

  final TextEditingController? controller;
  final Function(String?)? onSaving;
  final String? Function(String?) validator;
  final String? lableText;

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool isPassVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.password.tr(),
          style: AppStyles.textStyleSemiBoldPrim16.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: TextFormField(
            controller: widget.controller,
            validator: (v) => widget.validator(v),
            onSaved: (v) =>
                widget.onSaving == null ? null : widget.onSaving!(v),
            obscureText: !isPassVisible,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              enabledBorder: AppStyles.outlineBorder,
              focusedBorder: AppStyles.outlineBorder,
              errorBorder: AppStyles.errorOutlineBorder,
              focusedErrorBorder: AppStyles.errorOutlineBorder,
              suffixIcon: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Icon(
                  isPassVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppStyles.primaryColor,
                ),
                onTap: () {
                  setState(() {
                    isPassVisible = !isPassVisible;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
