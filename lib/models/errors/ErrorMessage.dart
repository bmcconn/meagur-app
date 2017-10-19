class ErrorMessage {
  String _error;

  ErrorMessage(this._error);
  ErrorMessage.fromMap(Map<String, dynamic> map) {
    _error = map['data']['error'];
  }

  String getError() => _error;

  void setError(String error) => _error = error;
}