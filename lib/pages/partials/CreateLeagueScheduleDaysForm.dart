import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meagur/models/leagues/League.dart';
import 'package:meagur/models/requests/LeagueScheduleRequest.dart';
import 'package:meagur/pages/ManageLeague.dart';
import 'package:meagur/services/MeagurService.dart';
import 'package:validator/validator.dart';

class CreateLeagueScheduleDaysForm extends StatefulWidget {

  final League _league;
  final LeagueScheduleRequest _leagueScheduleRequest;
  final MeagurService meagurService;

  CreateLeagueScheduleDaysForm(this._league, this._leagueScheduleRequest, this.meagurService);

  @override
  State createState() => new _CreateLeagueScheduleDaysFormState();
}

class _CreateLeagueScheduleDaysFormState extends State<CreateLeagueScheduleDaysForm> {

  bool _processing = false;

  Map<String, Widget> _dayCards = {};

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final Map<String, GlobalKey<FormFieldState<String>>> _fieldKeys = {
    "sunday": new GlobalKey<FormFieldState<String>>(),
    "monday": new GlobalKey<FormFieldState<String>>(),
    "tuesday": new GlobalKey<FormFieldState<String>>(),
    "wednesday": new GlobalKey<FormFieldState<String>>(),
    "thursday": new GlobalKey<FormFieldState<String>>(),
    "friday": new GlobalKey<FormFieldState<String>>(),
    "saturday": new GlobalKey<FormFieldState<String>>(),
  };

  @override
  void initState() {
    super.initState();
    Map<String, Widget> _cardsToAdd = {
      "sunday": new Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: new Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                title: const Text("SUNDAY"),
              ),
              new Divider(height: 1.0,),
              new Container(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0),
                child: new TextFormField(
                  key: _fieldKeys["sunday"],
                  validator: _validateSundayTimes,
                  decoration: const InputDecoration(
                      labelText: "Play at These Times"
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      "monday": new Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: new Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                title: const Text("MONDAY"),
              ),
              new Divider(height: 1.0,),
              new Container(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0),
                child: new TextFormField(
                  key: _fieldKeys["monday"],
                  validator: _validateMondayTimes,
                  decoration: const InputDecoration(
                      labelText: "Play at These Times"
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      "tuesday": new Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: new Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                title: const Text("TUESDAY"),
              ),
              new Divider(height: 1.0,),
              new Container(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0),
                child: new TextFormField(
                  key: _fieldKeys["tuesday"],
                  validator: _validateTuesdayTimes,
                  decoration: const InputDecoration(
                      labelText: "Play at These Times"
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      "wednesday": new Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: new Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                title: const Text("WEDNESDAY"),
              ),
              new Divider(height: 1.0,),
              new Container(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0),
                child: new TextFormField(
                  key: _fieldKeys["wednesday"],
                  validator: _validateWednesdayTimes,
                  decoration: const InputDecoration(
                      labelText: "Play at These Times"
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      "thursday": new Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: new Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                title: const Text("THURSDAY"),
              ),
              new Divider(height: 1.0,),
              new Container(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0),
                child: new TextFormField(
                  key: _fieldKeys["thursday"],
                  validator: _validateThursdayTimes,
                  decoration: const InputDecoration(
                      labelText: "Play at These Times"
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      "friday": new Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: new Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                title: const Text("FRIDAY"),
              ),
              new Divider(height: 1.0,),
              new Container(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0),
                child: new TextFormField(
                  key: _fieldKeys["friday"],
                  validator: _validateFridayTimes,
                  decoration: const InputDecoration(
                      labelText: "Play at These Times"
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      "saturday": new Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: new Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                title: const Text("SATURDAY"),
              ),
              new Divider(height: 1.0,),
              new Container(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0),
                child: new TextFormField(
                  key: _fieldKeys["saturday"],
                  validator: _validateSaturdayTimes,
                  decoration: const InputDecoration(
                      labelText: "Play at These Times"
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    };
    _dayCards = _cardsToAdd;
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _cards = [];

    widget._leagueScheduleRequest.getDaysOfWeekToPlayOn().forEach((day) {
      _cards.add(_dayCards[day.getDay()]);
    });

    if(_processing) {
      return new Center(child: new CircularProgressIndicator(),);
    } else {
      return new Form(
        key: _formKey,
        child: new ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text(
                    "Add Times For Each Day",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new IconButton(
                    icon: new Icon(
                      Icons.info,
                      color: Colors.grey,
                    ),
                    onPressed: () async {
                      return showDialog(
                          context: context,
                          child: new AlertDialog(
                            content: new Text(
                                "Here you can enter the time of day you would like to play at. You can enter as many times as you would like in the input field. Separate each time with a comma.  Example format: \n\n 8:00am, 5:00pm, 7:00pm"
                            ),
                          )
                      );
                    },
                  ),
                ],
              ),
              new SizedBox(height: 8.0),
              new Divider(height: 1.0,),
              new SizedBox(height: 16.0,),
              new Column(
                children: _cards,
              ),
              new SizedBox(height: 16.0,),
              new RaisedButton(
                onPressed: _handleCreateLeagueScheduleTap,
                child: new Text(
                  "Create League Schedule",
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Theme.of(context).accentColor,
              )
            ]
        ),
      );
    }
  }

  void _handleCreateLeagueScheduleTap() {
    final FormState form = _formKey.currentState;
    bool passedValidation = form.validate();
    form.save();

    if (passedValidation) {
      widget._leagueScheduleRequest.getDaysOfWeekToPlayOn().forEach((day) {
        List<String> times = _fieldKeys[day.getDay()].currentState.value.split(",");

        List<Time> timesToAdd = [];
        times.forEach((time) {
          String formattedTime = time.trim().toUpperCase();
          if(formattedTime.endsWith("PM")) {
            String removePM = formattedTime.replaceAll("PM", "");

            int hour = toInt(removePM.substring(0,1));
            int militaryHour = hour + 12;
            String minute = removePM.substring(removePM.indexOf(":"));

            Time timeToAdd = new Time(militaryHour.toString() + minute);
            timesToAdd.add(timeToAdd);

          } else if(formattedTime.toUpperCase().endsWith("AM")) {
            String removeAM = formattedTime.replaceAll("AM", "");

            int hour = toInt(removeAM.substring(0,1));
            String minute = removeAM.substring(removeAM.indexOf(":"));

            String timeHour;
            if (hour < 10) {
              timeHour = "0" + hour.toString();
            } else {
              timeHour = hour.toString();
            }

            Time timeToAdd = new Time(timeHour + minute);
            timesToAdd.add(timeToAdd);
          }
        });

        day.setTimes(timesToAdd);
      });

      setState((){
        _processing = true;
      });

      Future<String> future = widget.meagurService
          .postCreateLeagueSchedule(widget._leagueScheduleRequest, widget._league.getId());

      future
          .then((value) => handleSuccess(value))
          .catchError((error) => handleError(error));
    }

  }

  void handleSuccess(String value) {
    Navigator.of(context).removeRoute(ModalRoute.of(context));

    Navigator.of(context).pushReplacementNamed('/leagues');
   // Navigator.of(context).removeRoute(ModalRoute.of(context));
   // Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new ManageLeague(widget._league, widget.meagurService)));
  }

  void handleError(String error) {}

  String _validateSundayTimes(String value) {
    final FormFieldState<String> sundayTimesField = _fieldKeys["sunday"].currentState;

    if(sundayTimesField.value.isEmpty) {
      return "Please Enter At Least One Time";
    }
    return null;
  }

  String _validateMondayTimes(String value) {
    final FormFieldState<String> mondayTimesField = _fieldKeys["monday"].currentState;

    if(mondayTimesField.value.isEmpty) {
      return "Please Enter At Least One Time";
    }
    return null;
  }

  String _validateTuesdayTimes(String value) {
    final FormFieldState<String> tuesdayTimesField = _fieldKeys["tuesday"].currentState;

    if(tuesdayTimesField.value.isEmpty) {
      return "Please Enter At Least One Time";
    }
    return null;
  }

  String _validateWednesdayTimes(String value) {
    final FormFieldState<String> wednesdayTimesField = _fieldKeys["wednesday"].currentState;

    if(wednesdayTimesField.value.isEmpty) {
      return "Please Enter At Least One Time";
    }
    return null;
  }

  String _validateThursdayTimes(String value) {
    final FormFieldState<String> thursdayTimesField = _fieldKeys["thursday"].currentState;

    if(thursdayTimesField.value.isEmpty) {
      return "Please Enter At Least One Time";
    }
    return null;
  }

  String _validateFridayTimes(String value) {
    final FormFieldState<String> fridayTimesField = _fieldKeys["friday"].currentState;

    if(fridayTimesField.value.isEmpty) {
      return "Please Enter At Least One Time";
    }
    return null;
  }

  String _validateSaturdayTimes(String value) {
    final FormFieldState<String> saturdayTimesField = _fieldKeys["saturday"].currentState;

    if(saturdayTimesField.value.isEmpty) {
      return "Please Enter At Least One Time";
    }
    return null;
  }
}