import 'package:flutter/material.dart';
import 'package:meagur/pages/CreateLeaguePage.dart';
import 'package:meagur/services/MeagurService.dart';
import 'dart:async';
import 'dart:convert';
import 'package:meagur/models/teams/TeamList.dart';
import 'partials/TeamCardWidget.dart';
import 'package:meagur/models/leagues/LeagueList.dart';
import 'partials/LeagueCardWidget.dart';

class NavigationView {}

class InitialPage extends StatefulWidget {
  final int _index;
  final MeagurService meagurService;

  InitialPage(this._index, this.meagurService, {Key key}) : super(key: key);

  @override
  State createState() => new _InitialPageState();
}

class _InitialPageState extends State<InitialPage>
    with SingleTickerProviderStateMixin {

  int _currentIndex = 0;

  String _pageTitle;

  FloatingActionButton _floatingActionButton;

  Future<String> _listFuture;


  @override
  void initState() {
    super.initState();
    _currentIndex = widget._index;
    if (_currentIndex == 0) {
      _pageTitle = "Teams";
    } else {
      _pageTitle = "Managed Leagues";
      _floatingActionButton = new FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.white,), onPressed: _handleCreateLeagueTap);
    }
    _setFuture();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_pageTitle),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Brad McConn"),
              accountEmail: new Text("bmcconn@cord.edu"),
            ),
            new ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Create a new League"),
              onTap: () { Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new CreateLeaguePage(widget.meagurService))); },
            ),
          ],
        )
      ),
      body: new FutureBuilder(
        future: _listFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none: return new Container();
            case ConnectionState.waiting: return new Center(child: new CircularProgressIndicator(),);
            default:
              if(snapshot.hasError) {
                return new Text('ERR!');
              }
              else {
                List<Widget> list = [];
                if (_currentIndex == 0) {
                  TeamList teamList = new TeamList.fromMap(JSON.decode(snapshot.data));
                  teamList.getTeamList().forEach((team) {
                    list.add(new Container(
                      child: new TeamCardWidget(team, widget.meagurService),
                      margin: const EdgeInsets.only(bottom: 8.0),
                    ));
                  });
                } else {
                  LeagueList leagueList = new LeagueList.fromMap(JSON.decode(snapshot.data));
                  leagueList.getLeagueList().forEach((league) {
                    list.add(new Container(
                      child: new LeagueCardWidget(league, widget.meagurService),
                      margin: const EdgeInsets.only(bottom: 8.0),
                    ));
                  });
                }

                if (list.length == 0) {
                  return new Center(
                    child: new Icon(Icons.sentiment_dissatisfied, size: 48.0, color: Colors.grey,),
                  );
                }
                return new ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: list,
                );
              }

          }
        }
      ),
      floatingActionButton: _floatingActionButton,
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _handleBottomNavigationTap,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            title: const Text("Teams"),
          ),
          const BottomNavigationBarItem(
            icon: const Icon(Icons.edit),
            title: const Text("Managed Leagues"),
          ),
        ],
      ),
    );
  }

  void _setFuture() {
    if (_currentIndex == 0) {
      _listFuture = widget.meagurService.getBasketballTeams(true);
    } else {
      _listFuture = widget.meagurService.getBasketballLeagues(false);
    }
  }

  void _handleBottomNavigationTap(int position) {
    setState(() {
      _currentIndex = position;
      if (position == 0) {
        _setFuture();
        _pageTitle = "Teams";
        _floatingActionButton = null;

      } else if (position == 1) {
        _setFuture();
        _pageTitle = "Managed Leagues";
        _floatingActionButton = new FloatingActionButton(
            child: const Icon(Icons.add, color: Colors.white,), onPressed: _handleCreateLeagueTap);

      }
    });
  }

  void _handleCreateLeagueTap() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new CreateLeaguePage(widget.meagurService)));
  }


}
