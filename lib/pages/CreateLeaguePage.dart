import 'package:flutter/material.dart';
import 'package:meagur/pages/partials/CreateLeagueForm.dart';

class CreateLeaguePage extends StatefulWidget {

  @override
  State createState() => new _CreateLeaguePageState();
}

class _CreateLeaguePageState extends State<CreateLeaguePage> {

  Widget _body;

  @override
  void initState() {
    super.initState();
    _body = new CreateLeagueForm();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Create a League"),
      ),
      body:_body,
    );
  }
}