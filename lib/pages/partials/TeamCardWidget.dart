import 'package:flutter/material.dart';
import 'package:meagur/pages/LeagueHomePage.dart';
import 'package:meagur/models/teams/Team.dart';
import 'package:meagur/pages/TeamHomePage.dart';
import 'package:meagur/services/MeagurService.dart';

class TeamCardWidget extends StatefulWidget {
  TeamCardWidget(this._team, this.meagurService,{Key key}) : super(key: key);

  final Team _team;
  final MeagurService meagurService;

  @override
  State createState() => new _TeamCardWidgetState();
}

class _TeamCardWidgetState extends State<TeamCardWidget> {

  _TeamCardWidgetState();

  @override
  Widget build(BuildContext context) {

    return new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new InkWell(
              onTap: _handleTeamTap,
              child: new ListTile(
                leading: const Icon(Icons.image),
                title: new Text(widget._team.getName(), style: new TextStyle(color: Theme.of(context).primaryColor),),
                subtitle: new Text(widget._team.getLeague().getName()),
                trailing: new Text(widget._team.getTeamRecord().getWins().toString() + " - " + widget._team.getTeamRecord().getLosses().toString()+ " - " + widget._team.getTeamRecord().getTies().toString()),
              ),
            ),
            new Divider(height: 1.0,),
            new ButtonTheme.bar(
              child: new ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  new FlatButton(onPressed: _handleManageTap, child: const Text("Manage"),),
                  new FlatButton(onPressed: _handleLeagueHomeTap, child: const Text("League",),),
                ],
              ),
            )
          ],
        ),
      );
  }

  void _handleTeamTap() {

    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new TeamHomePage(widget._team.getId(), widget._team.getName(), widget.meagurService),
    ));
  }

  void _handleLeagueHomeTap() {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new LeagueHomePage(widget._team.getLeague().getId(), widget._team.getLeague().getName(), widget.meagurService),
    ));
  }

  void _handleManageTap() {

  }
}