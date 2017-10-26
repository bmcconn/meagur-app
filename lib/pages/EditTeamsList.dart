import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meagur/models/leagues/League.dart';
import 'package:meagur/pages/EditTeamDataPage.dart';

class EditTeamsList extends StatefulWidget {
  EditTeamsList(this._league, {Key key}) : super(key: key);

  final League _league;

  @override
  State createState() => new _EditTeamsListState();
}

class _EditTeamsListState extends State<EditTeamsList> {

  ScrollController _listController;

  @override
  void initState() {
    super.initState();
    _listController = new ScrollController();
  }

  Future<Null> _showInfo() async {
    return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text("Edit Team Data"),
        content: new Text("Here you can edit data about each team in the league.  Choose a team below to add managers, add members, or change the team name."),
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> items = [];

    items.add(new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Choose a Team to Edit",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16.0
          ),
        ),
        new IconButton(
          color: Colors.grey,
          icon: new Icon(Icons.info),
            onPressed: _showInfo
        ),
      ],
    ));

    items.add(new Divider());

    widget._league.getDivisions().getDivisionList().forEach((division) {
      division.getTeams().getTeamList().forEach((team) {
        items.add(new FlatButton(
          onPressed: () {_handleTeamTap(team.getId(), team.getName());},
          child: new Text(
            team.getName(),
            style: new TextStyle(color: Theme.of(context).accentColor),
          )
        ));
        items.add(new SizedBox(height: 8.0,));
      });
    });

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Team Data"),
      ),
      body: new ListView(
        padding: const EdgeInsets.all(16.0),
        controller: _listController,
        children: items,
      ),
    );
  }

  void _handleTeamTap(int teamId, String teamName) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new EditTeamDataPage(teamId)));
  }
}