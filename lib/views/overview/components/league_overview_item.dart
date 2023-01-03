import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/models/overview_league.dart';
import 'package:football_app/views/overview/bloc/overview_bloc.dart';
import 'package:football_app/views/overview/components/season_selector.dart';
import 'package:football_app/views/ranking/bloc/ranking_bloc.dart';
import 'package:football_app/views/ranking/ranking_page.dart';

import 'overview_league_title_view.dart';

class LeagueOverviewItem extends StatefulWidget {
  final OverviewLeague league;
  final List<int> seasonsList;

  const LeagueOverviewItem({
    super.key,
    required this.league,
    required this.seasonsList,
  });

  @override
  State<LeagueOverviewItem> createState() => _LeagueOverviewItemState();

  void selectLeague(
    BuildContext buildContext,
    int leagueId,
    int season,
  ) {
    Navigator.of(buildContext).push(
      MaterialPageRoute(
        builder: (newContext) => BlocProvider.value(
          value: BlocProvider.of<OverviewBloc>(buildContext),
          child: RankingPage(
            season: season.toString(),
            leagueId: leagueId.toString(),
          ),
        ),
      ),
    );
  }
}

class _LeagueOverviewItemState extends State<LeagueOverviewItem> {
  int selectedSeason = 2022;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OverviewLeagueTitleView(
          league: widget.league,
          onTap: (() =>
              widget.selectLeague(context, widget.league.id, selectedSeason)),
        ),
        SeasonSelector(
          seasonsList: widget.seasonsList,
          updateParent: (season) {
            selectedSeason = season;
          },
        ),
      ],
    );
  }
}
