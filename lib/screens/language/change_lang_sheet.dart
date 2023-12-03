import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:almaraqischool/utils/constants/syles.dart';

import '../../../../utils/translations/locale_keys.g.dart';
import '../../shared/button_widget.dart';
import 'change_lang_item.dart';
import 'language_provider.dart';

class ChangeLangeSheet extends StatelessWidget {
  const ChangeLangeSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Text(LocaleKeys.language.tr(), style: AppStyles.textStyleBold18),
          const SizedBox(height: 5),
          ChangeLangItem(lang: Language.ar),
          ChangeLangItem(lang: Language.en),
          const SizedBox(height: 17),
          const Spacer(),
          Consumer(builder: (context, ref, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ButtonWidget(
                elevation: 3,
                width: double.infinity,
                title: LocaleKeys.confirm.tr(),
                onButtonPressed: () async {
                  final bool isDone = await ref
                      .read(changeLangProvider)
                      .onApplyLangPressed(context);
                  if (isDone) Phoenix.rebirth(context);
                },
              ),
            );
          }),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
