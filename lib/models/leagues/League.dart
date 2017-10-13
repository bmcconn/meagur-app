import 'package:meagur/models/divisions/DivisionList.dart';

class League {
  int _id;
  String _name;

  int _numberOfTeams;
  int _numberOfDivisions;
  int _maxTeamMembers;
  int _numberOfGames;
  String _scheduleType;
  String _regularSeasonStartDate;
  String _regularSeasonEndDate;
  int _numberOfPlayoffTeams;
  String _playoffStartDate;
  String _playoffEndDate;
  String _playoffSeedingTiebreaker;
  bool _managerCanUpdateTeamMembers;
  bool _managerCanUpdateGames;

  DivisionList _divisions;

  League();

  League.overview(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
  }

  League.full(Map<String, dynamic> map) {
    _id = map['data']['id'];
    _name = map['data']['name'];
    _numberOfTeams = map['data']['number_of_teams'];
    _numberOfDivisions = map['data']['number_of_divisions'];
    _maxTeamMembers = map['data']['max_team_members'];
    _numberOfGames = map['data']['number_of_games'];
    _scheduleType = map['data']['schedule_type'];
    _regularSeasonStartDate = map['data']['regular_season_start_date'];
    _regularSeasonEndDate = map['data']['regular_season_end_date'];
    _numberOfPlayoffTeams = map['data']['number_of_playoff_teams'];
    _playoffStartDate = map['data']['playoff_start_date'];
    _playoffEndDate = map['data']['playoff_end_date'];
    _playoffSeedingTiebreaker = map['data']['playoff_seeding_tiebreaker'];
    _managerCanUpdateTeamMembers = map['data']['manager_can_update_team_members'];
    _managerCanUpdateGames = map['data']['manager_can_update_games'];
    _divisions = new DivisionList.inLeague(map['data']['divisions']);
  }

  int getId() => _id;
  String getName() => _name;
  int getNumberOfTeams() => _numberOfTeams;
  int getNumberOfDivisions() => _numberOfDivisions;
  int getMaxTeamMembers() => _maxTeamMembers;
  int getNumberOfGames() => _numberOfGames;
  String getScheduleType() => _scheduleType;
  String getRegularSeasonStartDate() => _regularSeasonStartDate;
  String getRegularSeasonEndDate() => _regularSeasonEndDate;
  int getNumberOfPlayoffTeams() => _numberOfPlayoffTeams;
  String getPlayoffStartDate() => _playoffStartDate;
  String getPlayoffEndDate() => _playoffEndDate;
  String getPlayoffSeedingTiebreaker() => _playoffSeedingTiebreaker;
  bool getManagerCanUpdateTeamMembers() => _managerCanUpdateTeamMembers;
  bool getManagerCanUpdateGames() => _managerCanUpdateGames;
  DivisionList getDivisions() => _divisions;

  void setId(int id) => _id = id;
  void setName(String name) => _name = name;
  void setNumberOfTeams(int numberOfTeams) => _numberOfTeams = numberOfTeams;
  void setNumberOfDivisions(int numberOfDivisions) => _numberOfDivisions = numberOfDivisions;
  void setMaxTeamMembers(int maxTeamMembers) => _maxTeamMembers = maxTeamMembers;
  void setNumberOfGames(int numberOfGames) => _numberOfGames = numberOfGames;
  void setScheduleType(String scheduleType) => _scheduleType = scheduleType;
  void setRegularSeasonStartDate(String regularSeasonStartDate) => _regularSeasonStartDate = regularSeasonStartDate;
  void setRegularSeasonEndDate(String regularSeasonEndDate) => _regularSeasonEndDate = regularSeasonEndDate;
  void setNumberOfPlayoffTeams(int numberOfPlayoffTeams) => _numberOfPlayoffTeams = numberOfPlayoffTeams;
  void setPlayoffStartDate(String playoffStartDate) => _playoffStartDate = playoffStartDate;
  void setPlayoffEndDate(String playoffEndDate) => _playoffEndDate = playoffEndDate;
  void setPlayoffSeedingTiebreaker(String playoffSeedingTiebreaker) => _playoffSeedingTiebreaker = playoffSeedingTiebreaker;
  void setManagerCanUpdateTeamMembers(bool managerCanUpdateTeamMembers) => _managerCanUpdateTeamMembers = managerCanUpdateTeamMembers;
  void setManagerCanUpdateGames(bool managerCanUpdateGames) => _managerCanUpdateGames = managerCanUpdateGames;
  void setDivisions(DivisionList divisions) => _divisions = divisions;
}