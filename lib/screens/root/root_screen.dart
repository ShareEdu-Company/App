import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:almaraqischool/screens/login/login_provider.dart';
import 'package:almaraqischool/utils/constants/urls.dart';
import 'package:almaraqischool/utils/router/route_error_screen.dart';
import 'package:almaraqischool/utils/translations/locale_keys.g.dart';
import '../../utils/router/router.dart';
import '../splash/splash_screen.dart';
import '../starting/starting_screen.dart';
import '../web_view_screen/web_view_screen.dart';
import 'root_screen_providers.dart';

class RootScreen extends ConsumerWidget {
  static const routeName = "/";
  const RootScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(rootScreenProvider).when(
          data: (FirstLaunchStatus status) {
            switch (status) {
              case FirstLaunchStatus.authed:
                return getFirstScreen(
                  ref.read(userTypeProvider.notifier).state.index + 1,
                );
              case FirstLaunchStatus.notAuthed:
                return const StartingScreen();
            }
          },
          error: (e, s) {
            return const RouteErrorScreen("حدث خطأ ما");
          },
          loading: () => const SplashScreen(),
        );
  }

  Widget getFirstScreen(int userIndex) {
    switch (userIndex) {
      case 1:
        return WebViewScreen(
          pageUrl: AppUrls.employeePage,
          title: LocaleKeys.staffServices.tr(),
        );
      case 2:
        return WebViewScreen(
          pageUrl: AppUrls.studentPage,
          title: LocaleKeys.studentServices.tr(),
        );
      case 3:
        return WebViewScreen(
          pageUrl: AppUrls.parentPage,
          title: LocaleKeys.parentServices.tr(),
        );
      case 4:
        return WebViewScreen(
          pageUrl: AppUrls.employeePage,
          title: LocaleKeys.staffServices.tr(),
        );
      default:
        return const StartingScreen();
    }
  }
}
