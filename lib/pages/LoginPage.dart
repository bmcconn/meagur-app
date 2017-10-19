import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meagur/main.dart';
import 'package:meagur/models/auth/ApiToken.dart';
import 'package:meagur/models/auth/LoginCredentials.dart';
import 'package:validator/validator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, @required this.onChanged}) : super(key: key);

  final bool loggingIn = false;
  final ValueChanged<bool> onChanged;

  @override
  State createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _emailFieldKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      new GlobalKey<FormFieldState<String>>();

  bool _inProgress = false;

  Widget _bottomRow() {
    if (_inProgress == false) {
      return _actionRow();
    } else if (_inProgress == true) {
      return _progressIndicator();
    } else {
      return _errorText();
    }
  }

  Widget _actionRow() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new FlatButton(
          onPressed: _handleRegisterPressed,
          child: new Text(
            "Register",
            style: new TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        new SizedBox(width: 16.0,),
        new FlatButton(
          onPressed: null,
          child: new Text(
            "Forgot Password",
            style: new TextStyle(color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }

  Widget _progressIndicator() {
    return new LinearProgressIndicator(
      value: null,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }

  Widget _errorText() {
    return new Text(
      "Those Credentials are Incorrect. Please Try Again.",
      style: new TextStyle(color: Theme.of(context).errorColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Meagur"),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          alignment: Alignment.topCenter,
          padding: new EdgeInsets.symmetric(horizontal: 16.0),
          child: new Form(
            key: _formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new TextFormField(
                  key: _emailFieldKey,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                  onSaved: (String value) {
                    _email = value;
                  },
                  validator: _validateEmail,
                ),
                new TextFormField(
                  key: _passwordFieldKey,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  onSaved: (String value) {
                    _password = value;
                  },
                  validator: _validatePassword,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                        child: new Container(
                      padding: new EdgeInsets.only(top: 16.0),
                      child: new RaisedButton(
                        onPressed: _handleSignIn,
                        color: Theme.of(context).accentColor,
                        child: new Text(
                          "Sign In",
                          style: new TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ),
                    ))
                  ],
                ),
                new SizedBox(
                  height: 16.0,
                ),
                new Divider(),
                _bottomRow(),
              ],
            )
          )
        ),
      )
    );
  }

  void _handleSignIn() {
    final FormState form = _formKey.currentState;
    bool passedValidation = form.validate();
    form.save();

    if (passedValidation) {
      setState(() {
        _inProgress = true;
      });
      Future<String> future =
          meagurService.getApiToken(new LoginCredentials(_email, _password));

      future
          .then((value) => _handleSuccess(value))
          .catchError((error) => _handleError(error));
    }
  }

  void _handleSuccess(String value) {
    if (value == '401') {
      print("Invalid");
      setState(() {
        _inProgress = null;
      });
    } else {
      setState(() {
        _inProgress = true;
      });

      ApiToken token = new ApiToken.fromMap(JSON.decode(value));

      Future<bool> saved =
          meagurService.getAuthProvider().saveApiToken(token.getAccessToken());

      saved.then((bool) {
        widget.onChanged(!widget.loggingIn);
      });
    }
  }

  void _handleError(FlutterError error) {
    print(error.toString());
  }

  String _validateEmail(String value) {
    final FormFieldState<String> emailField = _emailFieldKey.currentState;
    if (emailField.value == null ||
        emailField.value.isEmpty ||
        !isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String _validatePassword(String value) {
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField == null || passwordField.value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  void _handleRegisterPressed() {}
}
