import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meagur/main.dart';
import 'package:meagur/models/leagues/League.dart';
import 'package:meagur/pages/EditTeamsList.dart';

class ManageLeague extends StatefulWidget {

  final League _league;

  ManageLeague(this._league);



  @override
  State createState() => new _ManageLeagueState();
}

class _ManageLeagueState extends State<ManageLeague> with SingleTickerProviderStateMixin {

  Future<dynamic> _leagueFuture;
  League _detailedLeague;


  @override
  void initState() {
    super.initState();
    _leagueFuture = meagurService.getBasketballLeague(true, widget._league.getId());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Manage League"),
      ),
      body: new FutureBuilder(
        future: _leagueFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              return new Center(
                child: new CircularProgressIndicator(),
              );
            case ConnectionState.waiting:
              return new Center(
                child: new CircularProgressIndicator(),
              );
            default:
              _detailedLeague = snapshot.data;
              return new ListView(
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  new Text(
                    widget._league.getName(),
                    style: new TextStyle(
                        fontSize: 16.0
                    ),
                    textAlign: TextAlign.center,
                  ),
                  new SizedBox(height: 8.0,),
                  new Divider(color: Colors.grey,),
                  new SizedBox(height: 16.0,),
                  new Text(
                    "Teams",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 16.0
                    ),
                  ),
                  new SizedBox(height: 16.0,),
                  new FlatButton(
                    child: new Text(
                      "Edit Team Data",
                      style: new TextStyle(
                          color: Theme.of(context).accentColor
                      ),
                    ),
                    onPressed: _handleEditTeamDataPressed,
                  ),
                  new SizedBox(height: 16.0,),
                  new Text(
                    "Scheduling",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 16.0
                    ),
                  ),
                  new SizedBox(height: 16.0),
                  new FlatButton(
                      onPressed: _handleEditGameDataPressed,
                      child: new Text(
                        "Edit Game Data",
                        style: new TextStyle(
                            color: Theme.of(context).accentColor
                        ),
                      )
                  ),
                  new SizedBox(height: 16.0,),
                  new Text(
                    "League",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 16.0
                    ),
                  ),
                  new SizedBox(height: 16.0,),
                  new FlatButton(
                    child: new Text(
                      "Edit League Data",
                      style: new TextStyle(
                          color: Theme.of(context).accentColor
                      ),
                    ),
                    onPressed: _handleLeagueDataPressed,
                  ),
                  new SizedBox(height: 8.0,),
                  new FlatButton(
                    child: new Text(
                      "Add a Team",
                      style: new TextStyle(
                          color: Theme.of(context).accentColor
                      ),
                    ),
                    onPressed: _handleAddTeamPressed,
                  ),
                  new SizedBox(height: 16.0,),
                ],
              );
          }
        },
      ),
    );
  }

  void _handleEditTeamDataPressed() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new EditTeamsList(_detailedLeague)));
  }

  void _handleEditGameDataPressed() {

  }

  void _handleLeagueDataPressed() {

  }

  void _handleAddTeamPressed() {

  }
}