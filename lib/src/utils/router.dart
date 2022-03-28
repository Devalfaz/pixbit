import 'package:flutter/material.dart';
import 'package:pixbit/src/models/users.dart';
import 'package:pixbit/src/screens/details.dart';
import 'package:pixbit/src/screens/onboard.dart';
import 'package:pixbit/src/screens/resgister.dart';
import 'package:pixbit/src/settings/settings_controller.dart';

import '../screens/auth_screen.dart';
import '../screens/home.dart';

class RouterHelper {
  static const String onBoardRoute = '/';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String detailsRoute = '/details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onBoardRoute:
        return MaterialPageRoute(builder: (_) => const OnBoard());
      case loginRoute:
        return MaterialPageRoute(
            builder: (_) => AuthScreen(
                  controller: settings.arguments as SettingsController,
                ));
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const Register());
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) =>
                Home(controller: settings.arguments as SettingsController));
      case detailsRoute:
        return MaterialPageRoute(
            builder: (_) => Details(data: settings.arguments as UsersDataData));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  static Route<dynamic> onUnKnownRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      // settings: settings,
      builder: (BuildContext context) =>
          const Scaffold(body: Center(child: Text('Not Found'))),
    );
  }
}
