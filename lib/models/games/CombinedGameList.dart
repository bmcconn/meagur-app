import 'package:meagur/models/games/Game.dart';
import 'package:meagur/models/games/GameList.dart';

class CombinedGameList {
  List<Game> _games = [];

  CombinedGameList.fromLists(List<GameList> gameLists) {
    gameLists.forEach((gameList) {
      gameList.getGames().forEach((game) {
        _games.add(game);
      });
    });
  }

  List<Game> getGames() => _games;
}