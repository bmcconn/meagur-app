import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meagur/main.dart';
import 'package:meagur/models/errors/ErrorMessage.dart';
import 'package:meagur/models/games/GameList.dart';
import 'package:meagur/pages/partials/CompletedGameListItem.dart';
import 'package:meagur/pages/partials/ErrorMessageWidget.dart';
import 'package:meagur/pages/partials/NoLongerLoggedInWidget.dart';
import 'package:meagur/pages/partials/ScheduledGameListItem.dart';

class TeamScheduleWidget extends StatefulWidget {

  TeamScheduleWidget(this._teamId, {Key key}) : super(key: key);

  final int _teamId;

  @override
  State createState() => new _TeamScheduleWidgetState();
}

class _TeamScheduleWidgetState extends State<TeamScheduleWidget> {

  Future<dynamic> _teamGames;


  @override
  void initState() {
    super.initState();
    _teamGames = meagurService.getBasketballTeamGames(widget._teamId);
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: _teamGames,
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
              meagurService.mApiFutures.invalidate(
                  'basketball_leagues/' + widget._teamId.toString());
              return new ErrorMessageWidget(
                  "Sorry! An internal error has occured.  Try restarting the app, and if the issue persits please contact us.");
            } else {
              if (snapshot.data is ErrorMessage) {
                if (snapshot.data.getError() == "Unauthenticated.") {
                  return new NoLongerLoggedInWidget();
                }
              } else {
                List<Widget> games = [];
                GameList gameList = snapshot.data;

                gameList.getGames().sort((a, b) => a.getScheduledTime().compareTo(b.getScheduledTime()));

                gameList.getGames().forEach((game) {
                  if(game.getCompleted()) {
                    games.add(new CompletedGameListItem(game));
                  } else {
                    games.add(new ScheduledGameListItem(game));
                  }
                });

                return new ListView(
                  itemExtent: 97.0,
                  children: games,
                );
              }
            }
        }
      }
    );
  }
}
