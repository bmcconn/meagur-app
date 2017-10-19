import 'Team.dart';

class TeamList {

  List<Team> _teams = [];

  TeamList(this._teams);

  List<Team> getTeamList() => _teams;

  void setTeamList(List<Team> teams) => _teams = teams;

  TeamList.fromMap(Map<String, dynamic> map) {
    map['data'].forEach((team) {
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