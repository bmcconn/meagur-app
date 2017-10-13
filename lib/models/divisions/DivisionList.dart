import 'Division.dart';

class DivisionList {
  List<Division> _divisions = [];

  DivisionList(this._divisions);

  DivisionList.inLeague(Map<String, dynamic> map) {
    map['data'].forEach((division) {
      Division divisionToAdd = new Division.inLeague(division);
      _divisions.add(divisionToAdd);
    });
  }

  List<Division> getDivisionList() => _divisions;

  void setDivisionList(List<Division> divisions) => _divisions = divisions;
}