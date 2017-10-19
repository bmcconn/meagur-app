import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meagur/main.dart';

class NoLongerLoggedInWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(16.0),
      child: new Column(children: <Widget>[
        new Text("It looks like you're no longer logged in. Please choose an option below to continue."),
        new SizedBox(height: 16.0,),
        new RaisedButton(
          color: Theme.of(context).accentColor,
          onPressed: _handleLogin,
          child: new Text(
            "Login",
            style: new TextStyle(
              color: Colors.white
            ),
          ),
        ),
        new SizedBox(height: 16.0,),
        new RaisedButton(
          color: Theme.of(context).accentColor,
          onPressed: _handleExit,
          child: new Text(
            "Exit",
            style: new TextStyle(
              color: Colors.white
            ),
          ),
        )
      ]
      ),
    );
  }

  void _handleLogin() {
    unauthenticated();
  }

  _handleExit() {
    SystemNavigator.pop();
  }

}
