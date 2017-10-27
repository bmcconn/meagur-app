class PostTeamManagerInviteRequest {
  String _sport;
  int _leagueId;
  List<_Team> _teams;

  PostTeamManagerInviteRequest(String sport, int leagueId, Map teams) {
    _sport = sport;
    _leagueId = leagueId;

  }

  Map toJson() {
    return {
      "sport": _sport,
      "league_id": _leagueId,
      "_teams": _teams,
    };
  }
}



class _Team {
  int _id;
  List<_TeamManagerToAdd> _teamManagersToAdd;

  _Team(this._id, this._teamManagersToAdd);

  Map toJson() {
    return {
      "team_id": _id,
      "team_managers_to_add": _teamManagersToAdd,
    };
  }
}

class _TeamManagerToAdd {
  String _email;

  _TeamManagerToAdd(this._email);

  Map toJson() {
    return {
      "user_email": _email,
    };
  }
}