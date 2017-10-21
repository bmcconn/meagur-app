import 'package:meagur/models/games/Game.dart';

class GameList {
  List<Game> _games = [];
//  GameListPagination _pagination;

  GameList.fromMap(Map<String, dynamic> map) {
    map['data'].forEach((game) {
      _games.add(new Game.fromMap(game));
    });
 //   _pagination = new GameListPagination.fromMap(map['meta']['pagination']);
  }

  List<Game> getGames() => _games;
}

class GameListPagination {
  int _total;
  int _count;
  int _perPage;
  int _currentPage;
  int _totalPages;

  GameListPagination.fromMap(Map<String, dynamic> map) {
    _total = map['total'];
    _count = map['count'];
    _perPage = map['per_page'];
    _currentPage = map['current_page'];
    _totalPages = map['total_pages'];
  }

  int getTotal() => _total;
  int getCount() => _count;
  int getPerPage() => _perPage;
  int getCurrentPage() => _currentPage;
  int getTotalPages() => _totalPages;

  void setTotal(int total) => _total = total;
  void setCount(int count) => _count = count;
  void setPerPage(int perPage) => _perPage = perPage;
  void setCurrentPage(int currentPage) => _currentPage = currentPage;
  void setTotalPages(int totalPages) => _totalPages = totalPages;
}