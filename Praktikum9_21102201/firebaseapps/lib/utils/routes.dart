import 'package:flutter/material.dart';
import 'package:pertemuan_9/ui/home_screen.dart';
import 'package:pertemuan_9/ui/login.dart';
import 'package:pertemuan_9/ui/register.dart';

MaterialPageRoute _pageRoute({required Widget body, required RouteSettings settings}) =>
    MaterialPageRoute(builder: (_) => body, settings: settings);

Route<dynamic>? generateRoute(RouteSettings settings) {
  Route<dynamic>? _route;
  final _args = settings.arguments;

  switch (settings.name) {
    case rLogin:
      _route = _pageRoute(body: LoginScreen(), settings: settings);
      break;
    case rRegister:
      _route = _pageRoute(body: RegisterScreen(), settings: settings);
      break;
    case rHome:
      _route = _pageRoute(body: HomeScreen(), settings: settings);
      break;
  }

  return _route;
}

final NAV_KEY = GlobalKey<NavigatorState>();

const String rLogin = '/login';
const String rRegister = '/register';
const String rHome = '/home';
