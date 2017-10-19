import 'dart:convert';
import 'package:meagur/models/auth/LoginCredentials.dart';
import 'package:meagur/models/auth/User.dart';
import 'package:meagur/models/errors/ErrorMessage.dart';
import 'package:meagur/models/leagues/League.dart';
import 'package:meagur/models/leagues/LeagueList.dart';
import 'package:meagur/models/requests/CreateLeagueRequest.dart';
import 'package:meagur/models/requests/LeagueScheduleRequest.dart';
import 'package:meagur/models/teams/Team.dart';
import 'package:meagur/models/teams/TeamList.dart';
import 'package:quiver/cache.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:meagur/auth/AuthProvider.dart';
import 'package:http/http.dart' as http;

class MeagurService extends Meagur {
  MeagurService();
}

abstract class Meagur {
  static const String _SERVICE_ENDPOINT = "http://192.168.0.13:8000/api";
  static const String _AUTH_ENDPOINT = "http://192.168.0.13:8000/oauth/token";
  static final AuthProvider authProvider = new AuthProvider();
  MapCache<String, String> mApiFutures = new MapCache.lru(maximumSize: 10);

  AuthProvider getAuthProvider() => authProvider;

  void clearCacheResponse(String key) {
    mApiFutures.invalidate(key);
  }

  void clearCache() {
    mApiFutures = new MapCache.lru(maximumSize: 10);
  }

  Future<dynamic> getBasketballTeams(bool cacheResponse) async {

    Object response = await authProvider.getApiToken().then((value) {
      return mApiFutures.get('/basketball_teams', ifAbsent: (k) async {
        http.Client httpClient = createHttpClient();

        if(value == null) {
          return new ErrorMessage("Unauthenticated.");
        }

        http.Response response = await httpClient.get(
            Uri.encodeFull(_SERVICE_ENDPOINT + k),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'authorization': 'Bearer ' + value
            }
        );

        if(response.statusCode == 200) {
          if(cacheResponse) {
            mApiFutures.set(k, response.body);
          }

          return new TeamList.fromMap(JSON.decode(response.body));
        } else {
          ErrorMessage message = new ErrorMessage.fromMap(JSON.decode(response.body));
          return message;
        }
      });
    });

    return response;
  }

  Future<dynamic> getBasketballTeam(bool cacheResponse, int teamId) async {

    Object response = await authProvider.getApiToken().then((value) {
      return mApiFutures.get('/basketball_teams/' + teamId.toString(), ifAbsent: (k) async {
        http.Client httpClient = createHttpClient();

        if(value == null) {
          return new ErrorMessage("Unauthenticated.");
        }

        http.Response response = await httpClient.get(
            Uri.encodeFull(_SERVICE_ENDPOINT + k),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'authorization': 'Bearer ' + value
            }
        );

        if(response.statusCode == 200) {
          if(cacheResponse) {
            mApiFutures.set(k, response.body);
          }

          return new Team.detailed(JSON.decode(response.body)['data']);
        } else {
          ErrorMessage message = new ErrorMessage.fromMap(JSON.decode(response.body));
          return message;
        }
      });
    });

    return response;
  }

  Future<dynamic> getBasketballLeagues(bool cacheResponse) async {

    Object response = await authProvider.getApiToken().then((value) {
      return mApiFutures.get('/basketball_leagues', ifAbsent: (k) async {
        http.Client httpClient = createHttpClient();

        if(value == null) {
          return new ErrorMessage("Unauthenticated.");
        }
        http.Response response = await httpClient.get(
            Uri.encodeFull(_SERVICE_ENDPOINT + k),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'authorization': 'Bearer ' + value
            }
        );

        if(response.statusCode == 200) {
          if(cacheResponse) {
            mApiFutures.set(k, response.body);
          }

          return new LeagueList.fromMap(JSON.decode(response.body));
        } else {
          ErrorMessage message = new ErrorMessage.fromMap(JSON.decode(response.body));
          return message;
        }
      });
    });

    return response;
  }

  Future<dynamic> getBasketballLeague(bool cacheResponse, int leagueId) async {

    Object response = await authProvider.getApiToken().then((value) {
      return mApiFutures.get('/basketball_leagues/' + leagueId.toString(), ifAbsent: (k) async {
        http.Client httpClient = createHttpClient();

        if(value == null) {
          return new ErrorMessage("Unauthenticated.");
        }
        http.Response response = await httpClient.get(
            Uri.encodeFull(_SERVICE_ENDPOINT + k),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'authorization': 'Bearer ' + value
            }
        );

        if (response.statusCode == 200) {
          return new League.full(JSON.decode(response.body));
        } else {
          ErrorMessage message = new ErrorMessage.fromMap(JSON.decode(response.body));
          if(message.getError() == "Unauthenticated.") {

          }
          return message;
        }

      });
    });

    return response;
  }

  Future<bool> getUser() async {
    dynamic response = await authProvider.getApiToken().then((value) async {
      http.Client httpClient = createHttpClient();

      if(value == null) {
        return new ErrorMessage("Unauthenticated.");
      }
      http.Response response = await httpClient.get(
        Uri.encodeFull(_SERVICE_ENDPOINT + '/user'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'authorization': 'Bearer ' + value
        }
      );

      if(response.statusCode == 200) {
        User user = new User.fromMap(JSON.decode(response.body)['data']);
        return user;
      } else {
        ErrorMessage message = new ErrorMessage.fromMap(JSON.decode(response.body));
        return message;
      }
    });

    if(response is User) {
      authProvider.setUser(response);
      return true;
    } else {
      return false;
    }

  }

  Future<dynamic> postCreateLeague(CreateLeagueRequest createLeagueRequest, String sport) async {
    dynamic response = await authProvider.getApiToken().then((value) async {
      http.Client httpClient = createHttpClient();
      if(value == null) {
        return new ErrorMessage("Unauthenticated.");
      }

      const jsonCodec = const JsonCodec();

      http.Response response = await httpClient.post(
          Uri.encodeFull(_SERVICE_ENDPOINT + '/basketball_leagues'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'authorization': 'Bearer ' + value
          },
          body: jsonCodec.encode(createLeagueRequest)
      );

      if(response.statusCode == 200) {
        League league = new League.overview(JSON.decode(response.body)['data']);
        return league;
      } else {
        return new ErrorMessage.fromMap(JSON.decode(response.body));
      }
    });

    return response;

  }

  Future<dynamic> postCreateLeagueSchedule(LeagueScheduleRequest leagueScheduleRequest, int leagueId) async {
    dynamic response = await authProvider.getApiToken().then((value) async {
      if(value == null) {
        return new ErrorMessage("Unauthenticated.");
      }

      http.Client httpClient = createHttpClient();

      const jsonCodec = const JsonCodec();

      http.Response response = await httpClient.post(
          Uri.encodeFull(_SERVICE_ENDPOINT + '/basketball_leagues/' + leagueId.toString() + "/basketball_league_schedules"),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'authorization': 'Bearer ' + value
          },
          body: jsonCodec.encode(leagueScheduleRequest)
      );

      if(response.statusCode == 200) {
        return true;
      } else {
        return new ErrorMessage.fromMap(JSON.decode(response.body));
      }
    });

    return response;
  }

  Future<String> getApiToken(LoginCredentials loginCredentials) async {

    http.Client httpClient = createHttpClient();

    const loginRequest = const JsonCodec();

    http.Response response = await httpClient.post(
      Uri.encodeFull(_AUTH_ENDPOINT),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: loginRequest.encode(loginCredentials)
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.statusCode.toString();
    }
  }

  Future<bool> destroyApiToken() async {
    dynamic response = await authProvider.getApiToken().then((value) async {
      http.Client httpClient = createHttpClient();

      if(value == null) {
        return new ErrorMessage("Unauthenticated");
      }
      http.Response response = await httpClient.get(
          Uri.encodeFull(_SERVICE_ENDPOINT + '/logout'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'authorization': 'Bearer ' + value
          }
      );

      if(response.statusCode == 200) {
        return true;
      } else {
        ErrorMessage message = new ErrorMessage.fromMap(JSON.decode(response.body));
        return message;
      }
    });

    if(response == true) {
      bool destroyed = await authProvider.destroyApiToken();

      if(destroyed) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }

  }
}