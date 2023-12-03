import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:almaraqischool/screens/root/root_screen.dart';
import 'package:almaraqischool/utils/constants/syles.dart';
import 'package:almaraqischool/utils/helper/notification.dart';
import 'utils/router/router.dart';
import 'utils/translations/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  NotificationHelper().init();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      useOnlyLangCode: true,
      assetLoader: const CodegenLoader(),
      child: Phoenix(child: const ProviderScope(child: MyApp())),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: RoutesHelper.navigatorKey,
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'مدرسة المراقي',
      theme: AppStyles.appTheme,
      initialRoute: RootScreen.routeName,
      onGenerateRoute: RoutesHelper.generateRoute,
    );
  }
}
