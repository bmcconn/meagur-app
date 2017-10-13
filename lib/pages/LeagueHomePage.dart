import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meagur/models/divisions/DivisionList.dart';
import 'package:meagur/models/leagues/League.dart';
import 'package:meagur/pages/partials/LeagueStandingsWidget.dart';
import 'package:meagur/services/MeagurService.dart';
import 'package:meagur/models/teams/Team.dart';

class LeagueHomePage extends StatefulWidget {
  LeagueHomePage(this._leagueId, this._leagueName, this.meagurService,
      {Key key})
      : super(key: key);

  final int _leagueId;
  final String _leagueName;
  final MeagurService meagurService;

  @override
  State createState() {
    return new _LeagueHomePageState();
  }
}

class _LeagueHomePageState extends State<LeagueHomePage> with SingleTickerProviderStateMixin {
  _LeagueHomePageState();

  TabController _tabController;

  List<Tab> _tabs = [
    new Tab(text: "Standings",),
    new Tab(text: "Schedule"),
  ];


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget._leagueName),
        bottom: new TabBar(
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(8.0),
            child: new Card(
              color: Colors.grey[50],
              child: new LeagueStandingsWidget(widget._leagueId, widget.meagurService)
            )
          ),
          new Center(child: new Text("Schedule Page"),)
        ],
      )
    );
  }
}