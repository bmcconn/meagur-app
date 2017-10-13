import 'package:flutter/material.dart';
import 'package:meagur/models/leagues/League.dart';
import 'package:meagur/pages/ManageLeague.dart';
import 'package:meagur/services/MeagurService.dart';
import 'package:meagur/pages/LeagueHomePage.dart';

class LeagueCardWidget extends StatefulWidget {
  LeagueCardWidget(this._league, this.meagurService,{Key key}) : super(key: key);

  final League _league;
  final MeagurService meagurService;

  @override
  State createState() => new _LeagueCardWidgetState();
}

class _LeagueCardWidgetState extends State<LeagueCardWidget> {

  _LeagueCardWidgetState();

  @override
  Widget build(BuildContext context) {

    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new InkWell(
            onTap: _handleViewTap,
            child: new ListTile(
              //    leading: const Icon(Icons.image),
              title: new Text(widget._league.getName(), style: new TextStyle(color: Theme.of(context).primaryColor),),
            ),
          ),
          new Divider(height: 1.0,),
          new ButtonTheme.bar(
            child: new ButtonBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                new FlatButton(onPressed: _handleManageTap, child: const Text("Manage",),),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleViewTap() {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new LeagueHomePage(widget._league.getId(), widget._league.getName(), widget.meagurService),
    ));
  }

  void _handleManageTap() {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new ManageLeague(widget._league, widget.meagurService),
    ));
  }
}