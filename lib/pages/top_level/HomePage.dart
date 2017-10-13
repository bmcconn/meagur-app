import 'package:flutter/material.dart';
import 'package:meagur/auth/AuthProvider.dart';
import 'package:meagur/pages/LoginPage.dart';
import 'package:meagur/pages/InitialPage.dart';
import 'package:meagur/services/MeagurService.dart';

class HomePage extends StatefulWidget {

  final int _initialPageIndex;
  final MeagurService meagurService;

  HomePage(this._initialPageIndex, this.meagurService);

  @override
  State createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  AuthProvider auth = new AuthProvider();

  @override
  Widget build(BuildContext context) {
    if (auth.hasToken()) {
      return new InitialPage(widget._initialPageIndex, widget.meagurService);
    } else {
      return new LoginPage();
    }
  }
}