import 'package:meagur/models/leagues/League.dart';
import 'package:meagur/models/teams/TeamRecord.dart';
import 'package:meagur/models/teams/members/TeamMemberList.dart';

class Team {
  int _id;
  String _name;
  TeamRecord _teamRecord;

  TeamMemberList _teamManagers;
  TeamMemberList _teamMembers;

  League _league;

  Team(this._id, this._name, this._league);

  Team.index(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _league = new League.overview(map['league']['data']);
    _teamRecord = new TeamRecord.fromMap(map['record']);
  }

  Team.inDivision(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _teamRecord = new TeamRecord.fromMap(map['record']);
  }

  Team.detailed(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _teamRecord = new TeamRecord.fromMap(map['record']);
    _league = new League.overview(map['league']['data']);
    _teamManagers = new TeamMemberList.fromMap(map['team_managers']);
    _teamMembers = new TeamMemberList.fromMap(map['team_members']);
  }

  int getId() => _id;
  String getName() => _name;
  League getLeague() => _league;
  TeamRecord getTeamRecord() => _teamRecord;
  TeamMemberList getTeamManagers() => _teamManagers;
  TeamMemberList getTeamMembers() => _teamMembers;

  void setId(int id) => _id = id;
  void setName(String name) => _name = name;
  void setLeagueName(League league) => _league = league;
  void setTeamRecord(TeamRecord teamRecord) => _teamRecord = teamRecord;
  void setTeamManagers(TeamMemberList teamManagers) => _teamManagers = teamManagers;
  void setTeamMembers(TeamMemberList teamMembers) => _teamMembers = teamMembers;
}