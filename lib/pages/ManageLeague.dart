import 'package:flutter/material.dart';
import 'package:meagur/models/leagues/League.dart';
import 'package:meagur/services/MeagurService.dart';

class ManageLeague extends StatefulWidget {

  final League _league;
  final MeagurService meagurService;

  ManageLeague(this._league, this.meagurService);



  @override
  State createState() => new _ManageLeagueState();
}

class _ManageLeagueState extends State<ManageLeague> with SingleTickerProviderStateMixin {

  AppBar _appBar;


  @override
  void initState() {
    super.initState();
    _appBar = new AppBar(
      title: new Text(widget._league.getName()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _appBar,
      body: new ListView(
        padding: const EdgeInsets.all(16.0),

        children: <Widget>[
          new Text(
            "Manage League",
            style: new TextStyle(
              fontSize: 16.0
            ),
            textAlign: TextAlign.center,
          ),
          new SizedBox(height: 8.0,),
          new Divider(color: Colors.grey,),
          new SizedBox(height: 16.0,),
          new FlatButton(
            child: new Text(
              "Add Team Managers",
              style: new TextStyle(
                color: Theme.of(context).accentColor
              ),
            ),
            onPressed: _handleAddTeamManagersPressed,
          ),
          new SizedBox(height: 8.0,),
          new FlatButton(
            child: new Text(
            "Add Team Members",
              style: new TextStyle(
                  color: Theme.of(context).accentColor
              ),
            ),
            onPressed: _handleAddTeamManagersPressed,
          ),
          new SizedBox(height: 8.0,),
          new FlatButton(
            child: new Text(
              "Edit Team Data",
              style: new TextStyle(
                color: Theme.of(context).accentColor
              ),
            ),
            onPressed: _handleAddTeamManagersPressed,
          ),
          new SizedBox(height: 8.0,)
        ],
      ),
    );
  }

  void _handleAddTeamManagersPressed() {

  }
}