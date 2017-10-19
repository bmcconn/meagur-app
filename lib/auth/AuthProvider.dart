import 'dart:async';
import 'package:meagur/models/auth/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider {
  AuthProvider();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  User _user;
  String apiToken;

  bool hasToken() {
    return true;
  }

  String fakeApiToken() {
     return 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6Ijk3NjZmMjdhYzdhYmNiNDQyZjQ1N2Y0YjUzZjdjZGI5MTk1ZmYzYWZjMjU1YjNkY2E5MWUzODAwMzdmMmMwZTk2NTZhNTI0OTIzODM5ODFkIn0.eyJhdWQiOiIyIiwianRpIjoiOTc2NmYyN2FjN2FiY2I0NDJmNDU3ZjRiNTNmN2NkYjkxOTVmZjNhZmMyNTViM2RjYTkxZTM4MDAzN2YyYzBlOTY1NmE1MjQ5MjM4Mzk4MWQiLCJpYXQiOjE1MDM1NDY2NTgsIm5iZiI6MTUwMzU0NjY1OCwiZXhwIjoxNTM1MDgyNjU4LCJzdWIiOiIxIiwic2NvcGVzIjpbIioiXX0.SF_SgcWWAevMAia7j587TekG7gJx8vTuFbkIyT9AkcSQ-3zWIwqGjG-zE32SMPs2lc5HGSlcQz7-q_lOj4PWOLKLY7vBQc6qV47kBGvfxODLHVD355Zt0jFy7YCfDUVgt5OvduzReggOpEM3nQESWanWHtwjr7ojH5329trp076u0p-02RlzoRR-ppYbOOnYi0kLabu3BdfMcWoxxzwLoeJoL6Ip-JkUgiuNpE-vNKL-WTgSHgnoKa-ayHLN_XljGANIzWi88yQkrvAaJtW-IFpaVXppqpX7fpbTPbxcWTz2udsBWvwMTiXbNEFAlPf-LHqd9b9rjgE-kwxnG3_raz4FYOMh-2M78nVAnt69U5tQ626EYw642wAad7xoUNHKSuucZ2H-RBi1xHEYiS0CeTslbJ3JXVqLDqgcV3pNqH0j3HNGrqc_SvodhnXVnPZmQ_EPej2mToHA6SeoW8Pnp5pWuqBIhATMGgFvV4rpoJ7V4v8gwVHa6Dd7sxcLYaVJgdJJAfouL2_MUtTEEoCcCkGfuyJi2DUi41ziWBe_UClOXe00o3nN8-nU-dATm4l9glFAsoCHid_cqRg_cdsmq5IbmETOxWEhepSNUm-iJ_1uDdJ0EnXEaSjbS0lhTcgcUHEw2xBGnvY47N9lpcaRSd6kIf0wOEqVASdg1qiIJek';
  }

  Future<String> getApiToken() async {
    try {
      SharedPreferences prefs = await _prefs;
      return prefs.getString('api_token');
    } on Exception {
      return 'error';
    }
  }

  Future<bool> destroyApiToken() async {
    SharedPreferences prefs = await _prefs;
    prefs.remove('api_token');
    return true;
  }

  User getUser() => _user;

  void setUser(User user) => _user = user;

  saveApiToken(String token) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString('api_token', token);
  }
}