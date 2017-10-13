import 'Team.dart';
import 'package:meagur/models/leagues/League.dart';

class TeamList {

  List<Team> _teams = [];

  TeamList(this._teams);

  List<Team> getTeamList() => _teams;

  void setTeamList(List<Team> teams) => _teams = teams;

  TeamList.fromMap(Map<String, dynamic> map) {
    map['data'].forEach((team) {
    //  League league = new League.overview(team['league']);
      Team teamToAdd = new Team.index(team);
      _teams.add(teamToAdd);
    });
  }

  TeamList.inDivision(Map<String, dynamic> map) {
    map['data'].forEach((team) {
      Team teamToAdd = new Team.inDivision(team);
      _teams.add(teamToAdd);
    });
  }
}