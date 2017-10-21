import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meagur/main.dart';
import 'package:meagur/models/errors/ErrorMessage.dart';
import 'package:meagur/models/games/CombinedGameList.dart';
import 'package:meagur/models/games/GameList.dart';
import 'package:meagur/pages/partials/CompletedGameListItem.dart';
import 'package:meagur/pages/partials/NoLongerLoggedInWidget.dart';
import 'package:meagur/pages/partials/ScheduledGameListItem.dart';

class LeagueScheduleWidget extends StatefulWidget {
  LeagueScheduleWidget(this._leagueId, {Key key}) : super(key: key);

  final int _leagueId;

  @override
  State createState() => new _LeagueScheduleWidgetState();
}

class _LeagueScheduleWidgetState extends State<LeagueScheduleWidget> {

  Future<dynamic> _gamesFuture;

  @override
  void initState() {
    super.initState();
    _gamesFuture = getGames();
  }

  @override
  Widget build(BuildContext context) {

    return new FutureBuilder(
      future: _gamesFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            return new Center();
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          default:
            if(snapshot.hasError) {
              meagurService.mApiFutures.invalidate('basketball_leagues/' + widget._leagueId.toString() + 'completed_games?page=1');
              return new Text(snapshot.error.toString());
            } else {
              if(snapshot.data is ErrorMessage) {
                if(snapshot.data.getError() == "Unauthenticated.") {
                  return new NoLongerLoggedInWidget();
                } else {
                  return new Text(snapshot.data.getError());
                }
              } else {
                List<Widget> games = [];
                CombinedGameList gamesList = snapshot.data;

                gamesList.getGames().sort((a, b) => a.getScheduledTime().compareTo(b.getScheduledTime()));

                gamesList.getGames().forEach((game) {
                  if(game.getCompleted()) {
                    games.add(
                      new CompletedGameListItem(game)
                    );
                  } else {
                    games.add(
                      new ScheduledGameListItem(game)
                    );
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

  Future<dynamic> getGames() async {
    dynamic completedGamesFuture = await meagurService.getCompletedBasketballGames(widget._leagueId, 1);
    dynamic scheduledGamesFuture = await meagurService.getScheduledBasketballGames(widget._leagueId, 1);

    List<GameList> gameLists = [];

    if(scheduledGamesFuture is ErrorMessage || completedGamesFuture is ErrorMessage) {
      return new ErrorMessage("Unauthenticated.");
    }

    gameLists.add(completedGamesFuture);
    gameLists.add(scheduledGamesFuture);

    return new CombinedGameList.fromLists(gameLists);
  }
}