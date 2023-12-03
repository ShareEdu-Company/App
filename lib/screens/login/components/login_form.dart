import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:almaraqischool/utils/helper/validators.dart';
import 'package:almaraqischool/utils/translations/locale_keys.g.dart';

import '../../../shared/button_widget.dart';
import '../../../utils/constants/syles.dart';
import '../login_provider.dart';
import 'login_field_widget.dart';
import 'password_text_field_widget.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginProv = ref.watch(loginProvider.notifier);
    return Column(
      children: [
        Form(
          key: loginProv.formKey,
          child: Column(
            children: [
              LoginFieldWidget(
                onSaving: (p0) {
                  loginProv.setId(p0!);
                },
                validator: (p0) => ValidatorsHelper.numberValidator(p0!),
                labelText: LocaleKeys.idNum.tr(),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              PasswordTextFieldWidget(
                validator: (p0) => ValidatorsHelper.passwordValidator(p0!),
                onSaving: (p0) {
                  loginProv.setPass(p0!);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.userType.tr(),
              style: AppStyles.textStyleSemiBoldPrim16.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: DropdownButtonFormField(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  enabledBorder: AppStyles.outlineBorder,
                  focusedBorder: AppStyles.outlineBorder,
                ),
                value: ref.read(userTypeProvider.notifier).state,
                items: [
                  DropdownMenuItem(
                    value: UserType.employee,
                    child: Text(
                      LocaleKeys.employee.tr(),
                    ),
                  ),
                  DropdownMenuItem(
                    value: UserType.student,
                    child: Text(
                      LocaleKeys.student.tr(),
                    ),
                  ),
                  DropdownMenuItem(
                    value: UserType.parent,
                    child: Text(
                      LocaleKeys.parent.tr(),
                    ),
                  ),
                ],
                onChanged: (userType) {
                  ref.read(userTypeProvider.notifier).state = userType!;
                },
              ),
            )
          ],
        ),
        const SizedBox(height: 60),
        ButtonWidget(
          width: double.infinity,
          title: LocaleKeys.login.tr(),
          onButtonPressed: () => loginProv.onLoginPressed(context),
        ),
      ],
    );
  }
}
