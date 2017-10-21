import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meagur/models/games/Game.dart';

class CompletedGameListItem extends StatelessWidget {

  CompletedGameListItem(this.game, {Key key}) : super(key: key);

  final Game game;
  final DateFormat dayFormatter = new DateFormat('MMMEd');
  final DateFormat timeFormatter = new DateFormat('jm');

  @override
  Widget build(BuildContext context) {

    DateTime date = DateTime.parse(game.getScheduledTime());

    return new Container(
      decoration: new BoxDecoration(
          border: new BorderDirectional(bottom: new BorderSide(
              color: Colors.grey[300]
          ))
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: new Row(
        children: <Widget>[

          new Expanded(
            flex: 5,
            child: new Container(

              padding: const EdgeInsets.only(left: 16.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(game.getGameResults()[0].getTeam().getName()),
                  new SizedBox(height: 32.0,),
                  new Text(game.getGameResults()[1].getTeam().getName())
                ],
              ),
            ),
          ),
          new Expanded(
            flex: 1,
            child: new Container(
              padding: const EdgeInsets.only(right: 16.0),
              child: new Column(
                children: <Widget>[
                  new Text(game.getGameResults()[0].getScore().toString()),
                  new SizedBox(height: 32.0,),
                  new Text(game.getGameResults()[1].getScore().toString())
                ],
              ),
            ),
          ),
          new Expanded(
            flex: 2,
            child: new Container(
              decoration: new BoxDecoration(
                border: new Border(left: new BorderSide(color: Colors.grey[300]))
              ),
              padding: const EdgeInsets.only(right: 16.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                      dayFormatter.format(date).toString(),
                      style: new TextStyle(
                          color: Colors.grey[700]
                      )
                  ),
                  new Text(
                      timeFormatter.format(date)
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}