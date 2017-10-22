import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meagur/main.dart';
import 'package:meagur/models/errors/ErrorMessage.dart';
import 'package:meagur/models/requests/CreateLeagueRequest.dart';
import 'package:meagur/pages/CreateLeagueSchedulePage.dart';
import 'package:meagur/pages/partials/NoLongerLoggedInWidget.dart';
import 'package:validator/validator.dart';

class CreateLeagueForm extends StatefulWidget {

  @override
  State createState() => new _CreateLeagueFormState();
}

class _CreateLeagueFormState extends State<CreateLeagueForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _nameFormFieldKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _sportFormFieldKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _numberOfTeamsFormFieldKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _numberOfDivisionsFormFieldKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _maxTeamMembersFormFieldKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _teamManagerAddMembersFormFieldKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _teamManagerUpdateGamesFormFieldKey =
      new GlobalKey<FormFieldState<String>>();

  bool _teamManagerAddMembers = true;
  bool _teamManagerUpdateGames = false;

  String _sportDropdownValue;

  final List<String> _sports = <String>['Basketball', 'Volleyball',];

  bool _processing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_processing == false) {
      return new Form(
        key: _formKey,
        child: new DropdownButtonHideUnderline(
          child: new ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new FormField(
                      validator: _validateSport,
                      key: _sportFormFieldKey,
                      builder: (FormFieldState field) {
                        return  new InputDecorator(
                          decoration: new InputDecoration(
                            errorText: field.errorText,
                            labelText: "Sport",
                          ),
                          isEmpty: _sportDropdownValue == null,
                          child: new DropdownButton<String>(
                            value: _sportDropdownValue,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _sportDropdownValue = newValue;
                              });
                            },
                            items: _sports.map((String value) {
                              return new DropdownMenuItem<String>(
                                child: new Text(value),
                                value: value,
                              );
                            }).toList(),
                          ),
                        );
                      }
                  ),
                ],
              ),
              new Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: new TextFormField(
                  validator: _validateLeagueName,
                  key: _nameFormFieldKey,
                  decoration: new InputDecoration(
                    labelText: "League Name",
                  ),
                ),
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                      child: new TextFormField(
                    validator: _validateNumberOfTeams,
                    key: _numberOfTeamsFormFieldKey,
                    decoration: const InputDecoration(labelText: "No. of Teams"),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                  )),
                  const SizedBox(width: 16.0),
                  new Expanded(
                      child: new TextFormField(
                    validator: _validateNumberOfDivisions,
                    key: _numberOfDivisionsFormFieldKey,
                    decoration:
                        const InputDecoration(labelText: "No. of Divisions"),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                  )),
                ],
              ),
              new Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: new TextFormField(
                  validator: _validateMaxTeamMembers,
                  key: _maxTeamMembersFormFieldKey,
                  decoration: const InputDecoration(
                      labelText: "Maximum No. of Team Members"),
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: new FormField(
                  key: _teamManagerAddMembersFormFieldKey,
                  builder: (FormFieldState state) {
                    return new SwitchListTile(
                      secondary: new IconButton(
                        icon: const Icon(Icons.info),
                        onPressed: () async {
                          return showDialog(
                            context: context,
                            child: new AlertDialog(
                              content: new Text("Allow team managers to add and remove members from their own team. They will not be allowed to add more than the maximum specified here, including the manager of the team. The league manager is always allowed to add or remove team members or managers, regardless of how many are currently on the roster."),
                            )
                          );
                        },
                      ),
                      title: const Text("Allow Team Managers to Add Members to Their Team"),
                      value: _teamManagerAddMembers,
                      onChanged: (bool newValue) {
                        setState(() {
                          _teamManagerAddMembers = newValue;
                        });
                      });
                  }),
              ),
              new Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: new FormField(
                    key: _teamManagerUpdateGamesFormFieldKey,
                    builder: (FormFieldState state) {
                      return new SwitchListTile(
                          secondary: new IconButton(
                            icon: const Icon(Icons.info),
                            onPressed: () async {
                              return showDialog(
                                context: context,
                                child: new AlertDialog(
                                  content: new Text("This allows team managers to enter the score of games their team participates in. The managers of either team will be able to enter a game score only once after the game is completed. The league manager can always enter or edit scores of any game."),
                                )
                              );
                            },
                          ),
                          title: const Text("Allow Team Managers to Add Game Scores"),
                          value: _teamManagerUpdateGames,
                          onChanged: (bool newValue) {
                            setState(() {
                              _teamManagerUpdateGames = newValue;
                            });
                          });
                    }),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: new RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: _handleCreateLeagueTap,
                      child: new Text(
                        "Create League",
                        style: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    } else if(_processing == true){
      return new Center(child: new CircularProgressIndicator());
    } else {
      return new NoLongerLoggedInWidget();
    }
  }

  void _handleCreateLeagueTap() {
    final FormState form = _formKey.currentState;
    bool passedValidation = form.validate();
    form.save();

    if (passedValidation) {
      CreateLeagueRequest createLeagueRequest = new CreateLeagueRequest(
          _nameFormFieldKey.currentState.value,
          int.parse(_numberOfTeamsFormFieldKey.currentState.value),
          int.parse(_numberOfDivisionsFormFieldKey.currentState.value),
          _teamManagerAddMembers,
          _teamManagerUpdateGames,
          int.parse(_maxTeamMembersFormFieldKey.currentState.value));

      setState(() {
        _processing = true;
      });

      Future<dynamic> future = meagurService
          .postCreateLeague(createLeagueRequest, _sportDropdownValue);

      future
          .then((value) => handleSuccess(value))
          .catchError((error) => handleError(error));
    }
  }

  void handleSuccess(dynamic value) {
    if(value is ErrorMessage) {
      setState(() {
        print("Here");
        _processing = null;
      });
    } else {
      meagurService.mApiFutures.invalidate('/basketball_leagues');

      Navigator.of(context).removeRoute(ModalRoute.of(context));

      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) =>
          new CreateLeagueSchedulePage(value)));
    }
  }

  void handleError(dynamic error) {
    setState(() {
      print(error.toString());
      _processing = null;
    });
  }

  String _validateSport(String value) {
    if (_sportDropdownValue == null) {
      return "Please Select a Sport";
    }

    return null;
  }

  String _validateLeagueName(String value) {
    final FormFieldState<String> leagueNameField =
        _nameFormFieldKey.currentState;
    if (leagueNameField.value.isEmpty) {
      return "A Name is Required";
    }

    return null;
  }

  String _validateNumberOfTeams(String value) {
    final FormFieldState<String> numberOfTeamsField =
        _numberOfTeamsFormFieldKey.currentState;
    if (numberOfTeamsField.value.isEmpty) {
      return "No. of Teams is Required";
    }

    if (!isInt(numberOfTeamsField.value)) {
      return "Must be an Integer";
    }

    if (int.parse(numberOfTeamsField.value) <= 0) {
      return "Cannot be Zero";
    }
    return null;
  }

  String _validateNumberOfDivisions(String value) {
    final FormFieldState<String> numberOfDivisionsField =
        _numberOfDivisionsFormFieldKey.currentState;
    if (numberOfDivisionsField.value.isEmpty) {
      return "No. of Divisions is Required";
    }

    if (!isInt(numberOfDivisionsField.value)) {
      return "Must be an Integer";
    }

    if (int.parse(numberOfDivisionsField.value) <= 0) {
      return "Cannot be Zero";
    }
    return null;
  }

  String _validateMaxTeamMembers(String value) {
    final FormFieldState<String> maxTeamMembersField =
        _maxTeamMembersFormFieldKey.currentState;
    if (maxTeamMembersField.value.isEmpty) {
      return "Maximum No. of Team Members is Required";
    }

    if (!isInt(maxTeamMembersField.value)) {
      return "Must be an Integer";
    }

    if (int.parse(maxTeamMembersField.value) <= 0) {
      return "Cannot be Zero";
    }
    return null;
  }
}
