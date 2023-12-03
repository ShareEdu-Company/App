import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:almaraqischool/utils/constants/syles.dart';

import 'language_provider.dart';

enum Language { en, ar }

class ChangeLangItem extends ConsumerWidget {
  final Language lang;
  late final String title;
  ChangeLangItem({Key? key, required this.lang}) : super(key: key) {
    switch (lang) {
      case Language.ar:
        title = "العربية";
        break;
      case Language.en:
        title = "English";
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: () {
          ref.read(langProvider.notifier).state = lang;
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer(builder: (context, ref, _) {
              final selectedLang = ref.watch(langProvider);
              return Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selectedLang == lang
                        ? AppStyles.primaryColor
                        : const Color(0xffDFE2E5),
                    width: selectedLang == lang ? 5 : 3,
                  ),
                ),
              );
            }),
            const SizedBox(width: 10),
            Text(title, style: AppStyles.textStyleReg14)
          ],
        ),
      ),
    );
  }
}
