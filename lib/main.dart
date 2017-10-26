import 'package:flutter/material.dart';
import 'package:meagur/pages/InitialPage.dart';
import 'package:meagur/pages/top_level/HomePage.dart';
import 'package:meagur/services/MeagurService.dart';

void main() {
  runApp(new MyApp());
}

final defaultTheme = new ThemeData(
  accentColor: Colors.orange[900],
  primaryColor: Colors.blueGrey,
  hintColor: Colors.grey[700],
  splashColor: Colors.blueGrey[300]
);

final MeagurService meagurService = new MeagurService();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Meagur",
      home: new HomePage(0),
      theme: new ThemeData(
        accentColor: Colors.orange[900],
        primaryColor: Colors.blueGrey,
        hintColor: Colors.grey[700],
        splashColor: Colors.blueGrey[300],
        backgroundColor: Colors.lightBlue[200]
      ),
      routes: <String, WidgetBuilder> {
        '/teams': (BuildContext context) => new InitialPage(0),
        '/leagues': (BuildContext context) => new InitialPage(1),
      },

    );
  }
}

void unauthenticated() {
  main();
}
