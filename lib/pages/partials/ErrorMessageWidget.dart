import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String _error;

  ErrorMessageWidget(this._error);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(16.0),
      child: new Center(
        child: new Text(
          _error,
          style: new TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }


}