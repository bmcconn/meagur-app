import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meagur/models/requests/CreateLeagueRequest.dart';
import 'package:meagur/pages/InitialPage.dart';
import 'package:meagur/pages/partials/CreateLeagueForm.dart';
import 'package:meagur/services/MeagurService.dart';
import 'package:validator/validator.dart';

class CreateLeaguePage extends StatefulWidget {

  final MeagurService meagurService;

  CreateLeaguePage(this.meagurService);

  @override
  State createState() => new _CreateLeaguePageState();
}

class _CreateLeaguePageState extends State<CreateLeaguePage> {

  Widget _body;

  @override
  void initState() {
    super.initState();
    _body = new CreateLeagueForm(widget.meagurService);
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