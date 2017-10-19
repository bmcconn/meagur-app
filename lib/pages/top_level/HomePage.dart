import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meagur/main.dart';
import 'package:meagur/pages/LoginPage.dart';
import 'package:meagur/pages/InitialPage.dart';

class HomePage extends StatefulWidget {

  final int _initialPageIndex;

  HomePage(this._initialPageIndex);

  @override
  State createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  Future<bool> _retrievedUser;

  @override
  void initState() {
    super.initState();
    _retrievedUser = meagurService.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: _retrievedUser,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Scaffold(
              body: new Center(
                child: const FlutterLogo(size: 48.0),
              ),
            );
          case ConnectionState.waiting:
            return new Scaffold(
              body: new Center(
                child: const FlutterLogo(size: 48.0,),
              ),
            );
          default:
            if (snapshot.hasError) {
              return new Scaffold(
                body: new Center(
                  child: new Text(snapshot.error.toString()),
                ),
              );
            } else {
              if (snapshot.data == true) {
                return new InitialPage(
                  widget._initialPageIndex);
              } else {
                return new LoginPage(
                  onChanged: _handleLogin
                );
              }
            }
        }
      },
    );
  }

  void _handleLogin(bool loggingIn) {
    setState(() {
      _retrievedUser = meagurService.getUser();
    });
  }
}
