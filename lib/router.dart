import 'package:flutter/material.dart';
import 'package:windfall/ui/pages/authentication/login.dart';
import 'package:windfall/ui/pages/bottom_nav.dart';

import 'core/constants/named_routes.dart';



Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NamedRoutes.login:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Login(sessionExpired: true,),
      );
    case NamedRoutes.bottomNav:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const BottomNav(),
      );
    //todo::add more routes
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );



  }
}

PageRoute _getPageRoute({required String routeName, required Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}