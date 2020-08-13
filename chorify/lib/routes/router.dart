import 'package:auto_route/auto_route_annotations.dart';

import 'package:chorify/home/home.dart';
import 'package:chorify/listings/search_results_page.dart';
import 'package:chorify/login/login.dart';
import '../listings/search_results_page.dart';
import '../login/Testing.dart';

@autoRouter
class $Router {
  @initial
  Home homePage;
  LoginPage login;
  SearchResults searchResults;
  Testing testing;
}
