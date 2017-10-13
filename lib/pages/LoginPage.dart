import 'package:flutter/material.dart';
import 'package:validator/validator.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:meagur/models/auth/LoginCredentials.dart';
import 'package:meagur/auth/AuthProvider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  State createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";
  var responseData = '';

  AuthProvider auth = new AuthProvider();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _emailFieldKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      new GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Meagur"),
      ),
      body: new Container(
        padding: new EdgeInsets.symmetric(horizontal: 16.0),
        child: new Center(
            child: new Form(
                key: _formKey,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                              color: Theme.of(context).primaryColor,
                              child: new Text(
                                "Sign In",
                                style: new TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                        ))
                      ],
                    ),
                    new Text(responseData),
                  ],
                )
            )
        ),
      ),
    );
  }

  void _handleSignIn() {
    final FormState form = _formKey.currentState;
    bool passedValidation = form.validate();
    form.save();

    if (passedValidation) {
      _getApiToken(_email, _password);
    }
  }

  _getApiToken(String email, String password) async {
    var httpClient = createHttpClient();

    const jsonCodec = const JsonCodec();

    var jsonBody = jsonCodec.encode(new LoginCredentials(email, password));

    var response = await httpClient.post(
      "http://10.0.2.2:8000/oauth/token",
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonBody,
    );

    /*setState(() {
      responseData = response.statusCode.toString();
    });*/

    if (response.statusCode == 200) {
      setState(() {
        responseData = JSON.decode(response.body)['token_type'];
        //   responseData =  password;
      });
    } else {
      setState(() {
        responseData = '';
      });
    }
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
}
