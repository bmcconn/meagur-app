import 'package:flutter/material.dart';
import 'package:meagur/pages/LoginPage.dart';
import 'package:meagur/pages/top_level/HomePage.dart';
import 'package:meagur/services/MeagurService.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  final MeagurService meagurService = new MeagurService();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Meagur",
      home: new HomePage(0, meagurService),
      theme: new ThemeData(
        accentColor: Colors.lightBlue,
        primaryColor: Colors.blueGrey,
        hintColor: Colors.grey[700],
      ),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => new LoginPage(),
        '/teams': (BuildContext context) => new HomePage(0, meagurService),
        '/leagues': (BuildContext context) => new HomePage(1, meagurService),
      },
    );
  }
}
