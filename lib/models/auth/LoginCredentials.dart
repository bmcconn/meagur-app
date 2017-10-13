class LoginCredentials {
  String _grantType;
  String _clientId;
  String _clientSecret;
  String _username;
  String _password;
  String _scope;

  LoginCredentials(String email, String password) {
    this._grantType = "password";
    this._clientId = "2";
    this._clientSecret = "Z4khKYIlX1b6zI1cCUQFhMXRHsfbjDbaP2fXgj7C";
    this._username = email;
    this._password = password;
    this._scope = "*";
  }

  Map toJson() {
    return {
      'grant_type': _grantType,
      'client_id': _clientId,
      'client_secret': _clientSecret,
      'username': _username,
      'password': _password,
      'scope': _scope,
    };
  }
}