import 'package:meagur/models/auth/User.dart';

class TeamMember {
  int _id;
  bool _manager;
  User _user;

  TeamMember(this._id, this._manager, this._user);

  TeamMember.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _manager = map['manager'];
    _user = new User.fromMap(map['user']['data']);
  }

  int getId() => _id;
  bool getManager() => _manager;
  User getUser() => _user;

  void setId(int id) => _id = id;
  void setManager(bool manager) => _manager = manager;
  void setUser(User user) => _user = user;
}