import 'package:flutter/material.dart';
import 'package:meagur/models/leagues/League.dart';
import 'package:meagur/models/requests/LeagueScheduleRequest.dart';
import 'package:meagur/pages/partials/CreateLeagueScheduleDaysForm.dart';

class CreateLeagueScheduleDaysPage extends StatefulWidget {

  final League _league;
  final LeagueScheduleRequest _leagueScheduleRequest;

  CreateLeagueScheduleDaysPage(this._league, this._leagueScheduleRequest);

  @override
  State createState() => new _CreateLeagueScheduleDaysPageState();
}

class _CreateLeagueScheduleDaysPageState extends State<CreateLeagueScheduleDaysPage> {

  Widget _body;

  @override
  void initState() {
    super.initState();
    _body = new CreateLeagueScheduleDaysForm(widget._league, widget._leagueScheduleRequest);
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