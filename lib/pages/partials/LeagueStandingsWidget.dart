import 'dart:async';
import 'package:meagur/main.dart';
import 'package:flutter/material.dart';
import 'package:meagur/models/divisions/DivisionList.dart';
import 'package:meagur/models/errors/ErrorMessage.dart';
import 'package:meagur/models/teams/Team.dart';
import 'package:meagur/pages/partials/ErrorMessageWidget.dart';
import 'package:meagur/pages/TeamHomePage.dart';
import 'package:meagur/pages/partials/NoLongerLoggedInWidget.dart';

class LeagueStandingsWidget extends StatefulWidget {
  LeagueStandingsWidget(this._leagueId, {Key key}) : super(key: key);

  final int _leagueId;

  @override
  State createState() {
    return new _LeagueStandingsWidgetState();
  }


}

class _LeagueStandingsWidgetState extends State<LeagueStandingsWidget> {

  Future<dynamic> _basketballLeagueFuture;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _basketballLeagueFuture = meagurService.getBasketballLeague(true, widget._leagueId);
    _scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: _basketballLeagueFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Container();
          case ConnectionState.waiting:
            return new Center(
              child: new CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              meagurService.mApiFutures.invalidate('basketball_leagues/' + widget._leagueId.toString());
              return new ErrorMessageWidget("Sorry! An internal error has occured.  Try restarting the app, and if the issue persits please contact us.");
            } else {
              if (snapshot.data is ErrorMessage) {
                if(snapshot.data.getError() == "Unauthenticated.") {
                  return new NoLongerLoggedInWidget();
                }
              } else {
                DivisionList divisions = snapshot.data.getDivisions();

                List<Widget> tables = [];
                divisions.getDivisionList().forEach((division) {
                  division.getTeams().getTeamList().sort((Team a, Team b) =>
                      b.getTeamRecord().getWins().compareTo(
                          a.getTeamRecord().getWins()));
                  List<TableRow> rows = [];

                  rows.add(new TableRow(
                      children: <Widget>[
                        new Container(color: Theme
                            .of(context)
                            .primaryColor,
                          child: new Text(" ",
                            style: new TextStyle(color: Colors.grey[500],),),
                          margin: new EdgeInsets.only(bottom: 8.0),
                          padding: new EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 16.0),),
                        new Container(color: Theme
                            .of(context)
                            .primaryColor,
                          child: new Text(division.getName(),
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.fade,
                            softWrap: false,),
                          margin: new EdgeInsets.only(bottom: 8.0),
                          padding: new EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),),
                        new Container(color: Theme
                            .of(context)
                            .primaryColor,
                          child: const Text("Record",
                              style: const TextStyle(color: Colors.white)),
                          margin: new EdgeInsets.only(bottom: 8.0),
                          padding: new EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),),
                      ]
                  )
                  );
                  int count = 1;

                  division.getTeams().getTeamList().forEach((team) {
                    rows.add(new TableRow(children: <Widget>[
                      new Container(child: new Text(count.toString(),
                          style: new TextStyle(color: Colors.grey[700])),
                        padding: new EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),),
                      new InkWell(onTap: () {
                        _handleTeamTap(team.getId(), team.getName());
                      },
                          child: new Container(child: new Text(
                            team.getName(), overflow: TextOverflow.fade,
                            softWrap: false,
                            style: new TextStyle(color: Theme
                                .of(context)
                                .accentColor),),
                            padding: new EdgeInsets.all(8.0),)),
                      new Container(padding: new EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                          child: new Text(
                            team.getTeamRecord().getWins().toString() + " - " +
                                team.getTeamRecord().getLosses().toString() +
                                " - " +
                                team.getTeamRecord().getTies().toString(),
                            style: new TextStyle(color: Colors.grey[700]),)),
                    ]));
                    count += 1;
                  });

                  rows.add(new TableRow(children: <Widget>[
                    new SizedBox(height: 16.0,),
                    new SizedBox(height: 16.0,),
                    new SizedBox(height: 16.0,)
                  ]));

                  tables.add(new Table(children: rows,
                    columnWidths:
                    <int, TableColumnWidth>{
                      0: const IntrinsicColumnWidth(),
                      2: const IntrinsicColumnWidth()
                    },));
                });

                return new Container(
                  padding: const EdgeInsets.all(16.0),
                  child: new Card(
                    child: new ListView(
                      controller: _scrollController,
                      children: tables,
                    )
                  )
                );
              }
            }
        }
      },
    );
  }

  void _handleTeamTap(int teamId, String teamName) {

    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new TeamHomePage(teamId, teamName),
    ));
  }
}