import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meagur/models/teams/Team.dart';
import 'package:meagur/pages/partials/TeamMembersWidget.dart';
import 'package:meagur/services/MeagurService.dart';

class TeamHomePage extends StatefulWidget {

  TeamHomePage(this._teamId, this._teamName, this.meagurService, {Key key}) :  super(key: key);

  final int _teamId;
  final String _teamName;
  final MeagurService meagurService;

  @override
  State createState() => new _TeamHomePageState();
}

class _TeamHomePageState extends State<TeamHomePage> with SingleTickerProviderStateMixin {

  TabController _tabController;

  List<Tab> _tabs = [
    new Tab(text: "Schedule",),
    new Tab(text: "Team Members",)
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
        title: new Text(widget._teamName),
        bottom: new TabBar(
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: new FutureBuilder(
        future: widget.meagurService.getBasketballTeam(true, widget._teamId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none: return new Container();
            case ConnectionState.waiting: return new Center(child: new CircularProgressIndicator(),);
            default:
              if(snapshot.hasError) {
                return new Text('ERR!');
              }
              else {
                Team team = new Team.detailed(JSON.decode(snapshot.data)['data']);

                return new TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    new Center(child: new Text("Schedule"),),
                    new TeamMembersWidget(team)
                  ]
                );
              }
          }
        }
      )
    );
  }
}