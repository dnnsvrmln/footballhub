import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:football_app/models/overview_league.dart';
import 'package:http/http.dart' as http;
import '../models/overview_league_list.dart';
import '../models/team_venue.dart';
import '../models/league.dart';
import '../resources/constants_key.dart';

class LeagueService {
  static const _apiUrl = "api-football-beta.p.rapidapi.com";
  static const _standingsPath = "/standings";
  static const _teamsPath = "/teams";
  static const _headers = {
    "x-rapidapi-key": rapidApiKeyCasper,
    "x-rapidapi-host": _apiUrl
  };

  Future<League> getLeague(String leagueId, String season) async {
    final queryParams = {
      "season": season,
      "league": leagueId,
    };
    final uri = Uri.https(_apiUrl, _standingsPath, queryParams);

    try {
      final response = await http.get(uri, headers: _headers);
      return League.fromJson(
          jsonDecode(response.body)['response'][0]['league']);
    } catch (error) {
      // print(error);
      rethrow;
    }
  }

  Future<OverviewLeagueList> getLeaguesOverview() async {
    final String response =
        await rootBundle.loadString('lib/assets/leaguesOverview.json');
    return OverviewLeagueList.fromJson(jsonDecode(response)['response'][0]);
  }

  Future<League> getMockLeague(int leagueId) async {
    final leagueName = _getLeagueName(leagueId);
    final response =
        await rootBundle.loadString('lib/assets/data/$leagueName/mock.json');
    return League.fromJson(jsonDecode(response)['response'][0]['league']);
  }

  static String _getLeagueName(int leagueId) {
    switch (leagueId) {
      case 39:
        return "premier_league";
      case 61:
        return "ligue_1";
      case 78:
        return "bundesliga";
      case 88:
        return "eredivisie";
      case 135:
        return "serie_a";
      case 140:
        return "la_liga";
      default:
        return "No league name found";
    }
  }

  static Future<TeamVenue> getTeamVenue(String teamId) async {
    final queryParams = {"id": teamId};
    final uri = Uri.https(_apiUrl, _teamsPath, queryParams);

    try {
      final response = await http.get(uri, headers: _headers);
      return TeamVenue.fromJson(jsonDecode(response.body)['response'][0]);
    } catch (error) {
      // print(error);
      rethrow;
    }
  }

  Future<TeamVenue> getMockTeamVenue(String teamId) async {
    final String response =
        await rootBundle.loadString('lib/assets/mockTeamVenue.json');
    return TeamVenue.fromJson(jsonDecode(response)['response'][0]);
  }
}
