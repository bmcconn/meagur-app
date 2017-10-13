import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meagur/models/leagues/League.dart';
import 'package:meagur/models/requests/LeagueScheduleRequest.dart';
import 'package:meagur/pages/partials/CreateLeagueScheduleDaysForm.dart';
import 'package:meagur/pages/partials/TimePicker.dart';
import 'package:meagur/services/MeagurService.dart';
import 'package:validator/validator.dart';
import 'dart:convert';

class CreateLeagueScheduleDaysPage extends StatefulWidget {

  final League _league;
  final LeagueScheduleRequest _leagueScheduleRequest;
  final MeagurService meagurService;

  CreateLeagueScheduleDaysPage(this._league, this._leagueScheduleRequest, this.meagurService);

  @override
  State createState() => new _CreateLeagueScheduleDaysPageState();
}

class _CreateLeagueScheduleDaysPageState extends State<CreateLeagueScheduleDaysPage> {

  Widget _body;

  @override
  void initState() {
    super.initState();
    _body = new CreateLeagueScheduleDaysForm(widget._league, widget._leagueScheduleRequest, widget.meagurService);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Create League Schedule"),
      ),
      body: _body,
    );
  }
}