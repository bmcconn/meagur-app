import 'League.dart';

class LeagueList {

  List<League> _leagues = [];

  LeagueList(this._leagues);

  LeagueList.fromMap(Map<String, dynamic> map) {
    map['data'].forEach((league) {
      League leagueToAdd = new League.overview(league);
      _leagues.add(leagueToAdd);
    });
  }

  List<League> getLeagueList() => _leagues;

  void setLeagueList(List<League> leagues) => _leagues = leagues;


}