import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/local_database/local_database.dart';
import 'change_lang_item.dart';
import 'change_lang_sheet.dart';

final langProvider = StateProvider<Language>((ref) {
  return Language.ar;
});

final changeLangProvider =
    ChangeNotifierProvider.autoDispose<ChangeLangProvider>(
  (ref) => ChangeLangProvider(ref),
);

class ChangeLangProvider extends ChangeNotifier {
  final AutoDisposeChangeNotifierProviderRef<ChangeLangProvider> ref;
  ChangeLangProvider(this.ref);

  void onChangeLangPressed(BuildContext context, WidgetRef ref) {
    _syncLangProviderWithCurrentLang(context);
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? 270
            : null,
        child: const ChangeLangeSheet(),
      ),
    );
  }

  void _syncLangProviderWithCurrentLang(BuildContext context) {
    switch (context.locale.toString()) {
      case "ar":
        ref.read(langProvider.notifier).state = Language.ar;
        break;
      case "en":
        ref.read(langProvider.notifier).state = Language.en;
        break;
      default:
    }
  }

  Future<bool> onApplyLangPressed(BuildContext context) async {
    Navigator.of(context).pop();
    switch (ref.read(langProvider)) {
      case Language.ar:
        await context.setLocale(const Locale("ar"));
        return true;
      case Language.en:
        await context.setLocale(const Locale("en"));
        return true;
      default:
        return false;
    }
  }
}
