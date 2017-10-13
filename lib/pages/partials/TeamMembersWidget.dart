import 'package:flutter/material.dart';
import 'package:meagur/models/teams/Team.dart';

class TeamMembersWidget extends StatefulWidget {

  final Team _team;

  TeamMembersWidget(this._team, {Key key}) : super(key: key);

  @override
  State createState() => new _TeamMembersWidgetState();
}

class _TeamMembersWidgetState extends State<TeamMembersWidget> {


  @override
  Widget build(BuildContext context) {
    List<Container> managers = [];

    widget._team.getTeamManagers().getTeamMembers().forEach((manager) {
      managers.add(
          new Container(
            padding: new EdgeInsets.symmetric(vertical: 8.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(manager.getUser().getName(), style: new TextStyle(color: Colors.grey[500]),)
              ],
            ),
          )
      );
    });

    List<Container> members = [];

    widget._team.getTeamMembers().getTeamMembers().forEach((member) {
      members.add(
        new Container(
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(member.getUser().getName(), style: new TextStyle(color: Colors.grey[500]),)
            ],
          ),
        )
      );
    });

    return new ListView(
      padding: new EdgeInsets.all(16.0),
      children: <Widget>[
        new Text("Team Managers", style: new TextStyle(fontSize: 14.0), textAlign: TextAlign.center,),
        new Divider(),
        new Container(child: new Column(children: managers,), margin: new EdgeInsets.only(bottom: 16.0),),
        new Text("Team Members", style: new TextStyle(fontSize: 14.0), textAlign: TextAlign.center,),
        new Divider(),
        new Column(mainAxisAlignment: MainAxisAlignment.start, children: members,)
      ],
    );
  }
}