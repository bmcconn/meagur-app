import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meagur/main.dart';
import 'package:meagur/pages/top_level/HomePage.dart';

class LogoutPage extends StatefulWidget {


  @override
  State createState() {
    return new _LogoutPageState();
  }
}

class _LogoutPageState extends State<LogoutPage> {

  Future<dynamic> _destroyApiToken;

  @override
  void initState() {
    super.initState();
    _destroyApiToken = meagurService.destroyApiToken();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new FutureBuilder(
        future: _destroyApiToken,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new CircularProgressIndicator(),
                    new Text("Logging Out")
                  ],
                ),
              );
            case ConnectionState.waiting:
              return new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new CircularProgressIndicator(),
                    new Text("Logging Out")
                  ],
                ),
              );
            default:
              return new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: new Text(
                        "Exit",
                        style: new TextStyle(
                          color: Colors.white
                        ),
                      ),
                      onPressed: () { SystemNavigator.pop(); }
                    ),
                    new SizedBox(height: 32.0,),
                    new RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: new Text(
                        "Login",
                        style: new TextStyle(
                          color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        meagurService.clearCache();
                        Navigator.of(context).pushReplacement(new MaterialPageRoute(
                            builder: (BuildContext context) {
                              return new HomePage(0);
                            }
                          )
                        );
                      }
                    ),
                  ],
                ),
              );
          }
        }),
    );
  }
}

