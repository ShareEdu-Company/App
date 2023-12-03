import 'package:easy_localization/easy_localization.dart';
import 'package:almaraqischool/utils/translations/locale_keys.g.dart';

class ValidatorsHelper {
  static String? isEmptyValidator(String name) {
    if (name.trim().isEmpty) {
      return LocaleKeys.required_field.tr();
    }
    return null;
  }

  static String? numberValidator(String num) {
    if (num.trim().isEmpty) {
      return LocaleKeys.required_field.tr();
    }
    try {
      int.parse(num);
      if (num.length > 15) {
        return LocaleKeys.idHint.tr();
      }
      return null;
    } catch (e) {
      return LocaleKeys.numbers_only.tr();
    }
  }

  static String? passwordValidator(String pass) {
    if (pass.trim().length < 6) {
      return LocaleKeys.password_form_hint.tr();
    } else {
      return null;
    }
  }
}
