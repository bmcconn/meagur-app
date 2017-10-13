import 'package:meagur/models/teams/TeamList.dart';

class Division {
  int _id;
  String _name;
  TeamList _teams;

  Division(this._id, this._name, this._teams);

  Division.inLeague(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _teams = new TeamList.inDivision(map['teams']);
  }

  int getId() => _id;
  String getName() => _name;
  TeamList getTeams() => _teams;

  void setId(int id) => _id = id;
  void setName(String name) => _name = name;
  void setTeams(TeamList teams) => _teams = teams;

}