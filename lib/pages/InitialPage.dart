import 'package:flutter/material.dart';
import 'package:meagur/main.dart';
import 'package:meagur/models/errors/ErrorMessage.dart';
import 'package:meagur/pages/CreateLeaguePage.dart';
import 'package:meagur/pages/LogoutPage.dart';
import 'dart:async';
import 'partials/TeamCardWidget.dart';
import 'partials/LeagueCardWidget.dart';

class NavigationView {}

class InitialPage extends StatefulWidget {
  final int _index;
  InitialPage(this._index, {Key key}) : super(key: key);

  @override
  State createState() {
    return new _InitialPageState();
  }
}

class _InitialPageState extends State<InitialPage>
    with SingleTickerProviderStateMixin {

  int _currentIndex = 0;

  String _pageTitle;

  FloatingActionButton _floatingActionButton;

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
  }

  Future<dynamic> _getFuture() {
    if(_currentIndex == 0) {
      return meagurService.getBasketballTeams(true);
    } else {
      return meagurService.getBasketballLeagues(true);
    }
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
              accountName: new Text(meagurService.getAuthProvider().getUser().getName()),
              accountEmail: new Text(meagurService.getAuthProvider().getUser().getEmail()),
            ),
            new ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Create a new League"),
              onTap: _handleCreateLeagueTapFromDrawer,
            ),
            new ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Log Out"),
              onTap: _handleLogout,
            ),
            new AboutListTile()
          ],
        )
      ),
      body: new FutureBuilder(
        future: _getFuture(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none: return new Container();
            case ConnectionState.waiting: return new Center(child: new CircularProgressIndicator(),);
            default:
              if(snapshot.data is ErrorMessage) {
                return new Container(child: new Text(snapshot.data.getError()),);
              }
              else {
                List<Widget> list = [];
                if (_currentIndex == 0) {
                  snapshot.data.getTeamList().forEach((team) {
                    list.add(new Container(
                      child: new TeamCardWidget(team),
                      margin: const EdgeInsets.only(bottom: 8.0),
                    ));
                  });

                  list.add(new Container(height: 60.0,));
                } else {
                  snapshot.data.getLeagueList().forEach((league) {
                    list.add(new Container(
                      child: new LeagueCardWidget(league),
                      margin: const EdgeInsets.only(bottom: 8.0),
                    ));
                  });
                  list.add(new Container(height: 60.0,));
                }

                if (list.length == 0) {
                  return new Center(
                    child: new Icon(Icons.sentiment_dissatisfied, size: 48.0, color: Colors.grey,),
                  );
                }
                return new ListView(
                  primary: false,
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

  void _handleBottomNavigationTap(int position) {
    setState(() {
      _currentIndex = position;
      if (position == 0) {
        _pageTitle = "Teams";
        _floatingActionButton = null;

      } else if (position == 1) {
        _pageTitle = "Managed Leagues";
        _floatingActionButton = new FloatingActionButton(
            child: const Icon(Icons.add, color: Colors.white,), onPressed: _handleCreateLeagueTap);

      }
    });
  }

  void _handleCreateLeagueTap() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new CreateLeaguePage()));
  }

  void _handleCreateLeagueTapFromDrawer() {
    Navigator.of(context)..pop()..push(new MaterialPageRoute(builder: (BuildContext context) => new CreateLeaguePage()));
  }

  void _handleLogout() {
    Navigator.of(context)..pop..pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
      return new LogoutPage();
    }));
  }
}
