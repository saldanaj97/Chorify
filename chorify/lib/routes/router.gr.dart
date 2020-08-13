// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:chorify/home/home.dart';
import 'package:chorify/login/login.dart';
import 'package:chorify/listings/search_results_page.dart';
import 'package:chorify/login/Testing.dart';

class Router {
  static const homePage = '/';
  static const login = '/login';
  static const searchResults = '/search-results';
  static const testing = '/testing';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.homePage:
        return MaterialPageRoute(
          builder: (_) => Home(),
          settings: settings,
        );
      case Router.login:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
          settings: settings,
        );
      case Router.searchResults:
        return MaterialPageRoute(
          builder: (_) => SearchResults(),
          settings: settings,
        );
      case Router.testing:
        return MaterialPageRoute(
          builder: (_) => Testing(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
