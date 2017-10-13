import 'dart:convert';

import 'package:meagur/models/leagues/League.dart';
import 'package:meagur/models/requests/CreateLeagueRequest.dart';
import 'package:meagur/models/requests/LeagueScheduleRequest.dart';
import 'package:quiver/cache.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:meagur/auth/AuthProvider.dart';
import 'package:http/http.dart' as http;

class MeagurService extends Meagur {


  MeagurService();



}

abstract class Meagur {
//  static const String _SERVICE_ENDPOINT = "http://10.0.2.2:8000/api";
  static const String _SERVICE_ENDPOINT = "http://192.168.0.13:8000/api";
  static const String _AUTH_ENDPOINT = "http://10.0.2.2:8000/oauth/token";
  static final AuthProvider authProvider = new AuthProvider();
  MapCache<String, String> mApiFutures = new MapCache.lru(maximumSize: 10);

  AuthProvider getAuthProvider() => authProvider;

  void clearCacheResponse(String key) {
    mApiFutures.invalidate(key);
  }

  Future<String> getBasketballTeams(bool cacheResponse) async {

    return mApiFutures.get('/basketball_teams', ifAbsent: (k) async {
      http.Client httpClient = createHttpClient();

      http.Response response = await httpClient.get(
        Uri.encodeFull(_SERVICE_ENDPOINT + k),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'authorization': authProvider.authorizationToken()
        }
      );

      if (cacheResponse) {
        mApiFutures.set(k, response.body);
      }

      return response.body;
    });
  }

  Future<String> getBasketballTeam(bool cacheResponse, int teamId) async {
    return mApiFutures.get('/basketball_teams/' + teamId.toString(), ifAbsent: (k) async {
      http.Client httpClient = createHttpClient();

      http.Response response = await httpClient.get(
        Uri.encodeFull(_SERVICE_ENDPOINT + k),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'authorization': authProvider.authorizationToken()
        }
      );

      if (cacheResponse) {
        mApiFutures.set(k, response.body);
      }

      return response.body;
    });
  }

  Future<String> getBasketballLeagues(bool cacheResponse) async {

    return mApiFutures.get('/basketball_leagues', ifAbsent: (k) async {
      http.Client httpClient = createHttpClient();

      http.Response response = await httpClient.get(
          Uri.encodeFull(_SERVICE_ENDPOINT + k),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'authorization': authProvider.authorizationToken()
          }
      );

      if (cacheResponse) {
        mApiFutures.set(k, response.body);
      }

      return response.body;
    });
  }

  Future<String> getBasketballLeague(bool cacheResponse, int leagueId) async {
    return mApiFutures.get('/basketball_leagues/' + leagueId.toString(), ifAbsent: (k) async {
      http.Client httpClient = createHttpClient();

      http.Response response = await httpClient.get(
        Uri.encodeFull(_SERVICE_ENDPOINT + k),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'authorization': authProvider.authorizationToken()
        }
      );

      if(cacheResponse) {
        mApiFutures.set(k, response.body);
      }

      return response.body;
    });
  }

  Future<String> postCreateLeague(CreateLeagueRequest createLeagueRequest, String sport) async {
    http.Client httpClient = createHttpClient();

    const jsonCodec = const JsonCodec();



    http.Response response = await httpClient.post(
      Uri.encodeFull(_SERVICE_ENDPOINT + '/basketball_leagues'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': authProvider.authorizationToken()
      },
      body: jsonCodec.encode(createLeagueRequest)
    );

    return response.body;
  }

  Future<String> postCreateLeagueSchedule(LeagueScheduleRequest leagueScheduleRequest, int leagueId) async {
    http.Client httpClient = createHttpClient();

    const jsonCodec = const JsonCodec();

    http.Response response = await httpClient.post(
      Uri.encodeFull(_SERVICE_ENDPOINT + '/basketball_leagues/' + leagueId.toString() + "/basketball_league_schedules"),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': authProvider.authorizationToken()
      },
      body: jsonCodec.encode(leagueScheduleRequest)
    );

    return response.body;
  }
}