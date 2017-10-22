import 'package:flutter/material.dart';
import 'package:meagur/pages/partials/TeamMembersWidget.dart';
import 'package:meagur/pages/partials/TeamScheduleWidget.dart';

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
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new TeamScheduleWidget(widget._teamId),
          new TeamMembersWidget(widget._teamId),
        ]
      )
    );
  }
}