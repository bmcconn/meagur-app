class CreateLeagueRequest {
  String _name;
  int _numberOfTeams;
  int _numberOfDivisions;
  bool _managerCanUpdateTeamMembers;
  bool _managerCanUpdateGames;
  int _maxTeamMembers;

  CreateLeagueRequest(this._name, this._numberOfTeams, this._numberOfDivisions, this._managerCanUpdateTeamMembers, this._managerCanUpdateGames, this._maxTeamMembers);

  String getName() => _name;
  int getNumberOfTeams() => _numberOfTeams;
  int getNumberOfDivisions() => _numberOfDivisions;
  bool getManagerCanUpdateTeamMembers() => _managerCanUpdateTeamMembers;
  bool getManagerCanUpdateGames() => _managerCanUpdateGames;
  int getMaxTeamMembers() => _maxTeamMembers;

  void setName(String name) => _name = name;
  void setNumberOfTeams(int numberOfTeams) => _numberOfTeams = numberOfTeams;
  void setNumberOfDivisions(int numberOfDivisions) => _numberOfDivisions = numberOfDivisions;
  void setManagerCanUpdateTeamMembers(bool managerCanUpdateTeamMembers) => _managerCanUpdateTeamMembers = managerCanUpdateTeamMembers;
  void setManagerCanUpdateGames(bool managerCanUpdateGames) => _managerCanUpdateGames = managerCanUpdateGames;
  void setMaxTeamMembers(int maxTeamMembers) => _maxTeamMembers = maxTeamMembers;

  Map toJson() {
    return {
      'name': _name,
      'number_of_teams': _numberOfTeams,
      'number_of_divisions': _numberOfDivisions,
      'manager_can_update_team_members': _managerCanUpdateTeamMembers,
      'manager_can_update_games': _managerCanUpdateGames,
      'max_team_members': _maxTeamMembers
    };
  }
}