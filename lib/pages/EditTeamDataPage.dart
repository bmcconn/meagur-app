import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meagur/main.dart';
import 'package:meagur/pages/partials/EditTeamDataBody.dart';

class EditTeamDataPage extends StatefulWidget {
  EditTeamDataPage(this._teamId, {Key key}) : super(key: key);

  final int _teamId;

  @override
  State createState() => new _EditTeamDataPageState();
}

class _EditTeamDataPageState extends State<EditTeamDataPage> {

  Future<dynamic> _teamFuture;

  @override
  void initState() {
    super.initState();
    _teamFuture = meagurService.getBasketballTeam(true, widget._teamId);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Team Data"),
      ),
      body: new FutureBuilder(
        future: _teamFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              return new Center(
                child: new CircularProgressIndicator(),
              );
            case ConnectionState.waiting:
              return new Center(
                child: new CircularProgressIndicator(),
              );
            default:
              return new EditTeamDataBody(snapshot.data);
          }
        }
      ),
    );
  }
}