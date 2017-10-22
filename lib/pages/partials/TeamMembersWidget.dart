import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meagur/main.dart';
import 'package:meagur/models/errors/ErrorMessage.dart';
import 'package:meagur/pages/partials/ErrorMessageWidget.dart';
import 'package:meagur/pages/partials/NoLongerLoggedInWidget.dart';

class TeamMembersWidget extends StatefulWidget {

  final int _teamId;

  TeamMembersWidget(this._teamId, {Key key}) : super(key: key);

  @override
  State createState() => new _TeamMembersWidgetState();
}

class _TeamMembersWidgetState extends State<TeamMembersWidget> {

  Future<dynamic> _teamFuture;


  @override
  void initState() {
    super.initState();
    _teamFuture = meagurService.getBasketballTeam(true, widget._teamId);
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: _teamFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Center(
              child: new CircularProgressIndicator(),
            );
          case ConnectionState.waiting:
            return new Center(
              child: new CircularProgressIndicator(),
            );
          default:
            if(snapshot.hasError) {
              print(snapshot.error.toString());
              meagurService.mApiFutures.invalidate('basketball_teams/' + widget._teamId.toString());
              return new ErrorMessageWidget("Sorry! An internal error has occorued. Try restarting the app, and if the issue persits please contact us.");
            } else {
              if(snapshot.data is ErrorMessage) {

                if(snapshot.data.getError() == "Unauthenticated.") {
                  return new NoLongerLoggedInWidget();
                }

                return new Container();
              } else {
                List<Container> managers  = [];

                snapshot.data.getTeamManagers().getTeamMembers().forEach((manager) {
                  managers.add(
                      new Container(
                        padding: new EdgeInsets.symmetric(vertical: 8.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              manager.getUser().getName(),
                              style: new TextStyle(
                                  color: Colors.grey[500]
                              ),
                            )
                          ],
                        ),
                      )
                  );
                });

                List<Container> members = [];

                snapshot.data.getTeamMembers().getTeamMembers().forEach((member) {
                  members.add(
                      new Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              member.getUser().getName(),
                              style: new TextStyle(
                                  color: Colors.grey[500]
                              ),
                            )
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
        }
      },
    );
  }
}