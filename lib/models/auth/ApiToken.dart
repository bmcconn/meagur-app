class ApiToken {
  String _tokenType;
  int _expiresIn;
  String _accessToken;
  String _refreshToken;

  ApiToken.fromMap(Map<String, dynamic> map) {
    _tokenType = map['token_type'];
    _expiresIn = map['expires_in'];
    _accessToken = map['access_token'];
    _refreshToken = map['refresh_token'];
  }

  String getTokenType() => _tokenType;
  int getExpiresIn() => _expiresIn;
  String getAccessToken() => _accessToken;
  String getRefreshToken() => _refreshToken;
}