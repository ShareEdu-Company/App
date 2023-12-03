import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:almaraqischool/screens/login/login_provider.dart';
import 'package:almaraqischool/utils/constants/syles.dart';
import 'package:almaraqischool/utils/helper/tracking.dart';
import 'package:almaraqischool/utils/translations/locale_keys.g.dart';
import '../screens/language/language_provider.dart';
import 'back_button.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool hasBackButton;
  final bool hasTrackingButton;
  final bool hasLang;
  final TextStyle? titleTextStyle;
  final double titlePadding;
  const AppBarWidget({
    Key? key,
    required this.title,
    this.titleTextStyle,
    this.hasBackButton = false,
    this.hasTrackingButton = true,
    this.hasLang = true,
    this.titlePadding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppStyles.primaryColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 40,
              bottom: 15,
            ),
            child: Row(
              children: [
                const SizedBox(width: 5),
                if (hasBackButton) ...[
                  const BackButtonWidget(),
                  const SizedBox(width: 20)
                ],
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: titlePadding),
                  child: Text(
                    title,
                    style: titleTextStyle ??
                        AppStyles.textStyleSemiBold16.copyWith(
                          fontSize: 20,
                          color: const Color(0xffBDEBFB),
                        ),
                  ),
                ),
                const Spacer(),
                if (hasTrackingButton)
                  Consumer(
                    builder: (context, ref, child) {
                      if (ref.read(userTypeProvider.notifier).state ==
                              UserType.trackedEmployee ||
                          ref.read(userTypeProvider.notifier).state ==
                              UserType.employee) {
                        return Row(
                          children: [
                            Text(
                              LocaleKeys.track.tr(),
                              style: const TextStyle(
                                color: Color(0xffBDEBFB),
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Consumer(builder: (context, ref, _) {
                              final tracking = TrackingHelper(ref);
                              return Switch(
                                value: ref.watch(trackingProvider),
                                onChanged: ref
                                            .read(userTypeProvider.notifier)
                                            .state ==
                                        UserType.employee
                                    ? null
                                    : (v) {
                                        if (v) {
                                          ref
                                              .read(trackingProvider.notifier)
                                              .state = true;
                                          tracking.startTracking();
                                        } else {
                                          ref
                                              .read(trackingProvider.notifier)
                                              .state = false;
                                        }
                                      },
                                activeColor: const Color(0xffBDEBFB),
                                activeTrackColor: const Color(0xff32DB00),
                              );
                            }),
                            const SizedBox(width: 5),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                if (hasLang)
                  Consumer(builder: (context, ref, _) {
                    return InkWell(
                      onTap: () => ref
                          .read(changeLangProvider)
                          .onChangeLangPressed(context, ref),
                      child: const Icon(
                        Icons.language_rounded,
                        color: Color(0xffBDEBFB),
                        size: 28,
                      ),
                    );
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
