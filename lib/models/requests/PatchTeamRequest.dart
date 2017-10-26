class PatchTeamRequest {
  String _name;

  PatchTeamRequest(this._name);

  String getName() => _name;

  void setName(String name) => _name = name;

  Map toJson() {
    return {
      "name": _name
    };
  }
}