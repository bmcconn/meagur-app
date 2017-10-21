import 'package:meagur/models/teams/Team.dart';

class Game {
  int _id;
  String _scheduledTime;
  bool _completed;
  List<GameResult> _results = [];

  Game.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _scheduledTime = map['scheduled_time'];
    _completed = map['completed'];
    map['game_results']['data'].forEach((result) {
      _results.add(new GameResult.fromMap(result));
    });
  }

  int getId() => _id;
  String getScheduledTime() => _scheduledTime;
  bool getCompleted() => _completed;
  List<GameResult> getGameResults() => _results;
}

/*class GameResultsList {
  List<GameResult> _results = [];

  GameResultsList.fromMap(Map<String, dynamic> map) {
    map['data'].forEach((result) {
      _results.add(new GameResult.fromMap(result));
    });
  }

  List<GameResult> getGameResults() => _results;
}*/

class GameResult {
  int _id;
  int _score;
  Team _team;

  GameResult.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _score = map['score'];
    _team = new Team.inGame(map['team']['data']);
  }

  int getId() => _id;
  int getScore() => _score;
  Team getTeam() => _team;
}
