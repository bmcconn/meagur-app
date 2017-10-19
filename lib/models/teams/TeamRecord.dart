class TeamRecord {
  int _wins;
  int _losses;
  int _ties;

  TeamRecord(this._wins, this._losses, this._ties);

  TeamRecord.fromMap(Map<String, dynamic> map) {
    _wins = map['data']['wins'];
    _losses = map['data']['losses'];
    _ties = map['data']['ties'];
  }

  int getWins() => _wins;
  int getLosses() => _losses;
  int getTies() => _ties;

  void setWins(int wins) => _wins = wins;
  void setLosses(int losses) => _losses = losses;
  void setTies(int ties) => _ties = ties;
}