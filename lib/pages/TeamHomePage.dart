import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meagur/main.dart';
import 'package:meagur/models/errors/ErrorMessage.dart';
import 'package:meagur/pages/partials/NoLongerLoggedInWidget.dart';
import 'package:meagur/pages/partials/TeamMembersWidget.dart';

class TeamHomePage extends StatefulWidget {

  TeamHomePage(this._teamId, this._teamName, {Key key}) :  super(key: key);

  final int _teamId;
  final String _teamName;

  @override
  State createState() => new _TeamHomePageState();
}

class _TeamHomePageState extends State<TeamHomePage> with SingleTickerProviderStateMixin {

  TabController _tabController;

  List<Tab> _tabs = [
    new Tab(text: "Schedule",),
    new Tab(text: "Team Members",)
  ];

  Future<dynamic> _teamFuture;

  @override
  void initState() {
    super.initState();
    _teamFuture = meagurService.getBasketballTeam(true, widget._teamId);
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
        future: _teamFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none: return new Container();
            case ConnectionState.waiting: return new Center(child: new CircularProgressIndicator(),);
            default:
              if(snapshot.data is ErrorMessage) {
                if(snapshot.data.getError() == "Unauthenticated.") {
                  return new NoLongerLoggedInWidget();
                } else {
                  return new Placeholder();
                }
              }
              else {
                return new TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    new Center(child: new Text("Schedule"),),
                    new TeamMembersWidget(snapshot.data)
                  ]
                );
              }
          }
        }
      )
    );
  }
}