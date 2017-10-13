import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meagur/models/leagues/League.dart';
import 'package:meagur/models/requests/LeagueScheduleRequest.dart';
import 'package:meagur/pages/CreateLeagueScheduleDaysPage.dart';
import 'package:meagur/pages/partials/DatePicker.dart';
import 'package:meagur/pages/partials/DayOfWeekCheckbox.dart';
import 'package:meagur/services/MeagurService.dart';
import 'package:validator/validator.dart';

class CreateLeagueSchedulePage extends StatefulWidget {

  final League _league;
  final MeagurService meagurService;

  CreateLeagueSchedulePage(this._league, this.meagurService);

  @override
  State createState() => new _CreateLeagueSchedulePageState();
}

class _CreateLeagueSchedulePageState extends State<CreateLeagueSchedulePage> {

  String _scheduleType;
  final List<String> _scheduleTypes = <String>['Round Robin'];

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _numberOfGamesFormFieldKey = new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _numberOfGamesAtATimeFormFieldKey = new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _scheduleTypeFormFieldKey = new GlobalKey<FormFieldState<String>>();

  Map<String, bool> _dayValues = {
    "sunday": false,
    "monday": false,
    "tuesday": false,
    "wednesday": false,
    "thursday": false,
    "friday": false,
    "saturday": false,
  };

  DateTime _endDate = new DateTime.now();
  DateTime _startDate = new DateTime.now();

  String _dayErrorText = 'Please Select At Least One Day';

  Color _borderColor = Colors.grey[50];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Create League Schedule"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new FlatButton(
            child: new Text("Skip this Step", style: new TextStyle(color: Colors.lightBlue[100])),
            onPressed: _onSkip,
          )
        ]
      ),
      body: new WillPopScope(
        child: new ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              /*new Text(
                widget._league.getName(),
                style: new TextStyle(
                  fontSize: 20.0
                ),
              ),
              new SizedBox(height: 8.0,),
              new Divider(height: 1.0, color: Colors.grey,),*/
              new Form(
                key: _formKey,
                child: new DropdownButtonHideUnderline(
                  child: new ListBody(
                    children: <Widget>[
                      new FormField(
                        key: _scheduleTypeFormFieldKey,
                        validator: _validateScheduleType,
                        builder: (FormFieldState field) {
                          return new InputDecorator(
                            decoration: new InputDecoration(
                              labelText: "Schedule Type",
                              errorText: field.errorText,
                            ),
                            isEmpty: _scheduleType == null,
                            child: new DropdownButton(
                              value: _scheduleType,
                              isDense: true,
                              items: _scheduleTypes.map((String value) {
                                return new DropdownMenuItem<String>(
                                  child: new Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (String newValue) {
                                setState(() {
                                  _scheduleType = newValue;
                                });
                              }
                            ),
                          );
                        }
                      ),
                      new Row(
                        children: <Widget>[
                          new DatePicker(
                            labelText: 'Regular Season Start Date',
                            selectedDate: _startDate,
                            selectDate: (DateTime date) {
                              setState(() {
                                _startDate = date;
                              });
                            },
                          ),
                          new SizedBox(width: 16.0,),
                          new DatePicker(
                            labelText: 'Regular Season End Date',
                            selectedDate: _endDate,
                            selectDate: (DateTime date) {
                              setState(() {
                                _endDate = date;
                              });
                            },
                          ),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new TextFormField(
                              validator: _validateNumberOfGames,
                              key: _numberOfGamesFormFieldKey,
                              decoration: const InputDecoration(
                                labelText: "No. of Games per Team",
                              ),
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          new SizedBox(width: 16.0,),
                          new Expanded(
                            child: new TextFormField(
                              validator: _validateNumberOfGamesAtATime,
                              key: _numberOfGamesAtATimeFormFieldKey,
                              decoration: const InputDecoration(
                                labelText: "Games to Play at Once"
                              ),
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16.0,),
                      const Text(
                        "Days of the Week to Play On",
                        style: const TextStyle(
                          fontSize: 16.0
                        ),
                      ),
                      new Divider(color: Colors.grey[300],),
                      new FormField(
                        validator: _validateDays,
                        builder: (FormFieldState field) {
                          return new Column(
                            children: <Widget>[
                              new Row(
                                children: <Widget>[
                                  new DayOfWeekCheckbox(day: "Sunday", changed: _handleSundayCheckboxChange, isChecked: _dayValues["sunday"],),
                                  new SizedBox(width: 16.0,),
                                  new DayOfWeekCheckbox(day: "Monday", changed: _handleMondayCheckboxChange, isChecked: _dayValues["monday"],),
                                ],
                              ),
                              new Row(
                                children: <Widget>[
                                  new DayOfWeekCheckbox(day: "Tuesday", changed: _handleTuesdayCheckboxChange, isChecked: _dayValues["tuesday"],),
                                  new SizedBox(width: 16.0,),
                                  new DayOfWeekCheckbox(day: "Wednesday", changed: _handleWednesdayCheckboxChange, isChecked: _dayValues["wednesday"],),
                                ],
                              ),
                              new Row(
                                children: <Widget>[
                                  new DayOfWeekCheckbox(day: "Thursday", changed: _handleThursdayCheckboxChange, isChecked: _dayValues["thursday"],),
                                  new SizedBox(width: 16.0,),
                                  new DayOfWeekCheckbox(day: "Friday", changed: _handleFridayCheckboxChange, isChecked: _dayValues["friday"],),
                                ],
                              ),
                              new Row(
                                children: <Widget>[
                                  new DayOfWeekCheckbox(day: "Saturday", changed: _handleSaturdayCheckboxChange, isChecked: _dayValues["saturday"],),
                                ],
                              ),
                            ]
                          );
                        },
                      ),
                      new Container(
                        decoration: new BoxDecoration(
                          border: new Border.all(color: _borderColor),
                        ),
                        margin: const EdgeInsets.only(bottom: 2.0),
                      ),
                      new Text(_dayErrorText, textAlign: TextAlign.start, style: new TextStyle(color: _borderColor, fontSize: 12.0),),
                      new SizedBox(height: 24.0,),
                      new RaisedButton(
                        onPressed: _handleCreateLeagueScheduleTap,
                        color: Theme.of(context).accentColor,
                        child: new Text(
                          "Next",
                          style: new TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        onWillPop: _onWillPop
      )
    );
  }


  void _handleCreateLeagueScheduleTap() {
    final FormState form = _formKey.currentState;
    bool passedValidation = form.validate();
    form.save();

    if (passedValidation) {
      String formattedScheduleType = _scheduleType.replaceAll(" ", "_").toLowerCase();

      LeagueScheduleRequest leagueScheduleRequest = new LeagueScheduleRequest(toInt(_numberOfGamesFormFieldKey.currentState.value), formattedScheduleType, _startDate.toString(), _endDate.toString(), toInt(_numberOfGamesAtATimeFormFieldKey.currentState.value));

      List<Day> daysToAdd = [];
      _dayValues.forEach((key, value) {
        if (value) {
          daysToAdd.add(new Day(key));
        }
      });

      leagueScheduleRequest.setDaysOfWeekToPlayOn(daysToAdd);

      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new CreateLeagueScheduleDaysPage(widget._league, leagueScheduleRequest, widget.meagurService)));
    }
  }

  String _validateNumberOfGames(String value) {
    final FormFieldState<String> numberOfGamesField = _numberOfGamesFormFieldKey.currentState;
    if (numberOfGamesField.value.isEmpty) {
      return "No. of Games is Required";
    }

    if (!isInt(numberOfGamesField.value)) {
      return "Must be an Integer";
    }

    if (int.parse(numberOfGamesField.value) <= 0) {
      return "Cannot be Zero";
    }
    return null;
  }

  String _validateNumberOfGamesAtATime(String value) {
    final FormFieldState<String> numberOfGamesAtATimeField = _numberOfGamesAtATimeFormFieldKey.currentState;
    if (numberOfGamesAtATimeField.value.isEmpty) {
      return "No. of Games is Required";
    }

    if (!isInt(numberOfGamesAtATimeField.value)) {
      return "Must be an Integer";
    }

    if (int.parse(numberOfGamesAtATimeField.value) <= 0) {
      return "Cannot be Zero";
    }
    return null;
  }

  String _validateScheduleType(String value) {
    if (_scheduleType == null) {
      return "Please Select a Schedule Type";
    }
    return null;
  }

  String _validateDays(String value) {
    int daysChecked = 0;
    Color color = Colors.grey[50];
    _dayValues.forEach((key, value) {
      if(value) {
        daysChecked++;
      }
    });
    if (daysChecked == 0) {
      color = Theme.of(context).errorColor;
    }

    setState(() {
      _borderColor = color;
    });

    if (_borderColor == Theme.of(context).errorColor) {
      return 'Error';
    } else {
      setState(() {
        _borderColor = color;
      });
      return null;
    }
  }

  Future<Null> _onSkip() async {
    return showDialog(
      context: context,
      child: new AlertDialog(
        content: new SingleChildScrollView(
          child: new Text(
            "This will take you to the league home page without creating a schedule. You can always schedule games at a later time."
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Cancel"),
            onPressed: () { Navigator.of(context).pop(); },
          ),
          new FlatButton(
            child: new Text("Continue"),

            onPressed: () {
              Navigator.of(context).removeRoute(ModalRoute.of(context));
              Navigator.of(context).pushReplacementNamed('/leagues');
            },
          )
        ],
      )
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text("Exit without creating a schedule?"),
        content: new Text("This will exit the app. Your league has been sucessfully created, but no games are scheduled.  You an always schedule games at a later time."),
        actions: <Widget>[
          new FlatButton(onPressed: () => Navigator.of(context).pop(false), child: new Text('Cancel')),
          new FlatButton(onPressed: () => Navigator.of(context).pop(true), child: new Text('Exit')),
        ],
      ),
    ) ?? false;
  }


  void _handleSundayCheckboxChange(bool newValue) {
    setState(() {
      _dayValues["sunday"] = newValue;
    });
  }

  void _handleMondayCheckboxChange(bool newValue) {
    setState(() {
      _dayValues["monday"] = newValue;
    });
  }

  void _handleTuesdayCheckboxChange(bool newValue) {
    setState(() {
      _dayValues["tuesday"] = newValue;
    });
  }

  void _handleWednesdayCheckboxChange(bool newValue) {
    setState(() {
      _dayValues["wednesday"] = newValue;
    });
  }

  void _handleThursdayCheckboxChange(bool newValue) {
    setState(() {
      _dayValues["thursday"] = newValue;
    });
  }

  void _handleFridayCheckboxChange(bool newValue) {
    setState(() {
      _dayValues["friday"] = newValue;
    });
  }

  void _handleSaturdayCheckboxChange(bool newValue) {
    setState(() {
      _dayValues["saturday"] = newValue;
    });
  }
}