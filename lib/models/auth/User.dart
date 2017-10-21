class User {
  int _id;
  String _name;
  String _email;

  User(this._id, this._name, this._email);

  User.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _email = map['email'];
  }

  int getId() => _id;
  String getName() => _name;
  String getEmail() => _email;

  void setId(int id) => _id = id;
  void setName(String name) => _name = name;
  void setEmail(String email) => _email = email;
}