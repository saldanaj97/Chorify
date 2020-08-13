import 'package:flutter/material.dart';

import 'package:chorify/routes/router.gr.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chorify',
      theme: ThemeData(textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Gotham')),
      initialRoute: Router.homePage, // Start the app at the home page
      onGenerateRoute: Router.onGenerateRoute,
      navigatorKey: Router.navigatorKey,
    );
  }
}
