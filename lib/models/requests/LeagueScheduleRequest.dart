class LeagueScheduleRequest {
  int _numberOfGames;
  String _scheduleType;
  String _regularSeasonStartDate;
  String _regularSeasonEndDate;
  int _regularSeasonGamesAtATime;
  List<Day> _daysOfWeekToPlayOn;

  LeagueScheduleRequest(this._numberOfGames, this._scheduleType, this._regularSeasonStartDate, this._regularSeasonEndDate, this._regularSeasonGamesAtATime);

  List<Day> getDaysOfWeekToPlayOn() => _daysOfWeekToPlayOn;
  String getRegularSeasonStartDate() => _regularSeasonStartDate;

  void setDaysOfWeekToPlayOn(List<Day> days) => _daysOfWeekToPlayOn = days;

  Map toJson() {
    return {
      'number_of_games': _numberOfGames,
      'schedule_type': _scheduleType,
      'regular_season_start_date': _regularSeasonStartDate,
      'regular_season_end_date': _regularSeasonEndDate,
      'regular_season_games_at_a_time': _regularSeasonGamesAtATime,
      'days_of_week_to_play_on': _daysOfWeekToPlayOn
    };
  }
}

class Day {
  String _day;
  List<Time> _times;

  Day(this._day);

  String getDay() => _day;
  List<Time> getTimes() => _times;

  void setTimes(List<Time> times) => _times = times;

  Map toJson() {
    return {
      'day': _day,
      'times': _times
    };
  }
}

class Time {
  String _time;

  Time(this._time);

  String getTime() => _time;

  Map toJson() {
    return {
      'time': _time
    };
  }
}