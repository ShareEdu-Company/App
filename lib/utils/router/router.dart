import 'package:flutter/material.dart';
import 'package:almaraqischool/screens/employee/employee_screen.dart';
import 'package:almaraqischool/screens/login/login_screen.dart';
import 'package:almaraqischool/screens/parent/parent_screen.dart';
import 'package:almaraqischool/screens/root/root_screen.dart';
import 'package:almaraqischool/screens/splash/splash_screen.dart';
import 'package:almaraqischool/screens/starting/starting_screen.dart';
import 'package:almaraqischool/screens/web_view_screen/web_view_screen.dart';
import '../../screens/guest/guest_screen.dart';
import 'route_error_screen.dart';

class RoutesHelper {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static Route generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RootScreen.routeName:
        return pageRoute(const RootScreen());
      case SplashScreen.routeName:
        return pageRoute(const SplashScreen());
      case StartingScreen.routeName:
        return pageRoute(const StartingScreen());
      case GuestScreen.routeName:
        return pageRoute(GuestScreen());
      case LoginScreen.routeName:
        return pageRoute(const LoginScreen());
      case EmployeeScreen.routeName:
        return pageRoute(const EmployeeScreen());
      case ParentScreen.routeName:
        return pageRoute(const ParentScreen());
      case WebViewScreen.routeName:
        final pageData = args as Map<String, String>;
        return pageRoute(WebViewScreen(
          pageUrl: pageData["pageUrl"]!,
          title: pageData["title"]!,
        ));

      default:
        return MaterialPageRoute(
          builder: (context) => const RouteErrorScreen("Route error"),
        );
    }
  }

  static MaterialPageRoute pageRoute(Widget screen, {Object? arg}) {
    return MaterialPageRoute(
      builder: (context) => screen,
    );
  }
}

void pushNamedAndRemoveUntil(context, route, {arguments}) {
  Navigator.of(context).pushNamedAndRemoveUntil(route, ModalRoute.withName('/'),
      arguments: arguments);
}

void pushNamed(context, route, {arguments}) {
  Navigator.of(context).pushNamed(route, arguments: arguments);
}
