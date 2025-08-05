import 'package:flutter/material.dart';



Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case NamedRoutes.profile:
    //   return _getPageRoute(
    //     routeName: settings.name!,
    //     viewToShow: const Profile(),
    //   );
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