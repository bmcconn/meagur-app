import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meagur/main.dart';
import 'package:meagur/models/requests/PatchTeamRequest.dart';
import 'package:meagur/models/teams/Team.dart';
import 'package:meagur/pages/ManageLeague.dart';
import 'package:validator/validator.dart';

class EditTeamDataBody extends StatefulWidget {
  EditTeamDataBody(this._team, {Key key}) : super(key: key);

  final Team _team;

  @override
  State createState() => new _EditTeamDataBodyState();
}

class _EditTeamDataBodyState extends State<EditTeamDataBody> {

  String _teamName;
  final GlobalKey<FormState> _managerFormKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _memberFormKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _nameFormFieldKey = new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _managerNameFormFieldKey = new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _managerEmailFormFieldKey = new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _memberNameFormFieldKey = new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _memberEmailFormFieldKey = new GlobalKey<FormFieldState<String>>();
  Widget _teamNameRow;
  Widget _bottomSectionWidget;
  Widget _newNameDialogContent;

  Widget _nameRow() {
    return new Row(
      children: <Widget>[
        new Text(
          _teamName,
          style: new TextStyle(
              fontSize: 20.0
          ),
          overflow: TextOverflow.fade,
        ),
        new SizedBox(width: 16.0,),
        new IconButton(
          icon: new Icon(Icons.edit, color: Colors.orange[900],),
          onPressed: _handleEditTeamNameTap,
        ),
      ],
    );
  }

  Widget _nameTextFormField() {
    return new TextFormField(
      key: _nameFormFieldKey,
      validator: _validateTeamName,
      decoration: new InputDecoration(
          labelText: " Team Name"
      ),
    );
  }

  Widget _linearProgressIndicator() {
    return new LinearProgressIndicator(
      value: null,
      backgroundColor: Colors.orange[500],
    );
  }

  Widget _addManagerRow() {
    return new Row(
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: new IconButton(
            color: Colors.lightBlue,
            icon: new Icon(Icons.add),
            onPressed: _handleAddManagerTapped,
          ),
        ),
        new Expanded(
          flex: 3,
          child: new Text(
            "Team Managers",
            style: new TextStyle(
              fontSize: 16.0
            ),
          ),
        ),

      ],
    );
  }

  Widget _teamManagersList() {
    List<Widget> managers = [];

    widget._team.getTeamManagers().getTeamMembers().forEach((manager) {
      managers.add(
          new Row(
            children: <Widget>[
              new Expanded(
                flex: 1,
                child:
                new IconButton(
                  color: Colors.red,
                  icon: new Icon(Icons.remove),
                  onPressed: () => _handleRemoveTeamMemberTap(manager.getId()),
                ),
              ),
              new Expanded(
                flex: 3,
                child:
                new Text(manager.getUser().getName()),

              ),

            ],
          )
      );
    });

    return new Column(
      children: managers,
    );
  }

  Widget _addMemberRow() {
    return new Row(
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: new IconButton(
            color: Colors.lightBlue,
            icon: new Icon(Icons.add),
            onPressed: _handleAddMemberTapped,
          ),
        ),
        new Expanded(
          flex: 3,
          child: new Text(
            "Team Members",
            style: new TextStyle(
              fontSize: 16.0
            ),
          ),
        ),
      ],
    );
  }

  Widget _teamMembersList() {
    List<Widget> managers = [];

    widget._team.getTeamMembers().getTeamMembers().forEach((member) {
      managers.add(
          new Row(
            children: <Widget>[
              new Expanded(
                flex: 1,
                child:
                new IconButton(
                  color: Colors.red,
                  icon: new Icon(Icons.remove),
                  onPressed: () => _handleRemoveTeamMemberTap(member.getId()),
                ),
              ),
              new Expanded(
                flex: 3,
                child:
                new Text(member.getUser().getName()),

              ),

            ],
          )
      );
    });

    return new Column(
      children: managers,
    );
  }

  Widget _bottomSection() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: new Column(
            children: <Widget>[
              _addManagerRow(),
              _teamManagersList(),
            ],
          ),
        ),
        new SizedBox(width: 8.0,),
        new Expanded(
          flex: 1,
          child: new Column(
            children: <Widget>[
              _addMemberRow(),
              _teamMembersList()
            ],
          ),
        ),
      ],
    );
  }

  Widget _inviteManagerDialog() {
    return new Column(
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.only(top: 64.0),
          child: new AlertDialog(
            content: new Form(
              key: _managerFormKey,
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    key: _managerNameFormFieldKey,
                    validator: _validateManagerName,
                    decoration: new InputDecoration(
                        labelText: "Name"
                    ),
                  ),
                  new TextFormField(
                    key: _managerEmailFormFieldKey,
                    validator: _validateManagerEmail,
                    decoration: new InputDecoration(
                        labelText: "Email"
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: const Text("Cancel"),
                onPressed: () { Navigator.of(context).pop(); },
              ),
              new FlatButton(
                child: const Text("Submit"),
                onPressed: () {
                  final FormState form = _managerFormKey.currentState;
                  bool passedValidation = form.validate();
                  form.save();
                  if(passedValidation) {
                    Navigator.of(context).pop({
                      'name': _managerNameFormFieldKey.currentState.value,
                      'email': _managerEmailFormFieldKey.currentState.value,
                    });
                  }
                },
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _inviteMemberDialog() {
    return new Column(
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.only(top: 64.0),
          child: new AlertDialog(
            content: new Form(
              key: _memberFormKey,
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    key: _memberNameFormFieldKey,
                    validator: _validateMemberName,
                    decoration: new InputDecoration(
                        labelText: "Name"
                    ),
                  ),
                  new TextFormField(
                    key: _memberEmailFormFieldKey,
                    validator: _validateMemberEmail,
                    decoration: new InputDecoration(
                        labelText: "Email"
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: const Text("Cancel"),
                onPressed: () { Navigator.of(context).pop(); },
              ),
              new FlatButton(
                child: const Text("Submit"),
                onPressed: () {
                  final FormState form = _memberFormKey.currentState;
                  bool passedValidation = form.validate();
                  form.save();
                  if(passedValidation) {
                    Navigator.of(context).pop({
                      'name': _memberNameFormFieldKey.currentState.value,
                      'email': _memberEmailFormFieldKey.currentState.value,
                    });
                  }
                },
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _confirmationDialog() {
    return new AlertDialog(
      content: const Text("The invite has been successfully sent. The user will receive an email asking to accept."),
    );
  }

  @override
  void initState() {
    super.initState();
    _teamName = widget._team.getName();
    _teamNameRow = _nameRow();
    _bottomSectionWidget = _bottomSection();
    _newNameDialogContent = _nameTextFormField();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    items.add(_teamNameRow);

    items.add(new Divider(color: Colors.grey,));
    items.add(new SizedBox(height: 16.0,));

    items.add(_bottomSectionWidget);

    return new Container(
      child: new SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          children: items,
        ),
      ),
    );
  }

  Future<Null> _handleEditTeamNameTap() async {

    String newName = await showDialog(
      context: context,
      child: new Column(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.only(top: 64.0),
            child: new AlertDialog(
              content: _newNameDialogContent,
              actions: <Widget>[
                new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () { Navigator.of(context).pop(); },
                ),
                new FlatButton(
                  child: const Text("Submit"),
                  onPressed: () {
                    final FormFieldState formField = _nameFormFieldKey.currentState;
                    bool passedValidation = formField.validate();
                    formField.save();
                    if(passedValidation == true) {

                      Navigator.of(context).pop(_nameFormFieldKey.currentState.value);
                    }
                  },
                )
              ],
            ),
          ),
        ],
      )
    );

    if(newName != null) {
      setState(() {
        _teamNameRow = _linearProgressIndicator();
        _bottomSectionWidget = new Container();
      });
      print(newName);

      meagurService.mApiFutures.invalidate('/basketball_teams/' + widget._team.getId().toString());
      meagurService.mApiFutures.invalidate('/basketball_leagues/' + widget._team.getLeague().getId().toString());

      PatchTeamRequest patchTeamRequest = new PatchTeamRequest(newName);

      await meagurService.patchBasketballTeam(widget._team.getId(), patchTeamRequest);

      Navigator.of(context)
        ..pop()
        ..pop()
        ..pop()
        ..push(new MaterialPageRoute(builder: (BuildContext context) => new ManageLeague(widget._team.getLeague())));
    }
  }

  Future<Null> _handleAddManagerTapped() async {
    Map inviteData = await showDialog(
      context: context,
      child: _inviteManagerDialog()
    );

    if(inviteData != null) {
      setState(() {
        _teamNameRow = _linearProgressIndicator();
        _bottomSectionWidget = new Container();
      });

      print(inviteData['name']);

      Map request = {
        "sport": "basketball",
        "league_id": widget._team.getLeague().getId(),
        "teams": [
          {
            "team_id": widget._team.getId(),
            "team_managers_to_add": [
              {
                "user_email": inviteData['email']
              }
            ]
          }
        ]
      };

      bool success = await meagurService.postBasketballTeamManagementInvite(request);

      if(success) {
        setState(() {
          _teamNameRow = _nameRow();
          _bottomSectionWidget = _bottomSection();
        });
        showDialog(
            context: context,
            child: _confirmationDialog()
        );
      }
    }
  }

  Future<Null> _handleAddMemberTapped() async {
    Map inviteData = await showDialog(
      context: context,
      child: _inviteMemberDialog()
    );

    if(inviteData != null) {
      setState(() {
        _teamNameRow = _linearProgressIndicator();
        _bottomSectionWidget = new Container();
      });

      Map request = {
        "sport": "basketball",
        "team_id": widget._team.getId(),
        "team_members_to_add": [
          {
            "user_email": inviteData['email']
          }
        ]
      };

      bool success = await meagurService.postBasketballTeamMembershipInvite(request);

      if(success) {
        setState(() {
          _teamNameRow = _nameRow();
          _bottomSectionWidget = _bottomSection();
        });
        showDialog(
            context: context,
            child: _confirmationDialog()
        );
      }
    }
  }

  void _handleRemoveTeamMemberTap(int memberId) {

  }

  String _validateTeamName(String value) {
    FormFieldState<String> state = _nameFormFieldKey.currentState;

    if(state.value.isEmpty) {
      return "Please enter a name";
    }

    return null;
  }

  String _validateManagerName(String value) {
    FormFieldState<String> state = _managerNameFormFieldKey.currentState;

    if(state.value.isEmpty) {
      return "Please enter a name";
    }

    return null;
  }

  String _validateManagerEmail(String value) {
    FormFieldState<String> state = _managerEmailFormFieldKey.currentState;

    if(state.value.isEmpty || state.value == null || !isEmail(value)) {
      return "Please enter a valid email";
    }

    return null;
  }

  String _validateMemberName(String value) {
    FormFieldState<String> state = _memberNameFormFieldKey.currentState;

    if(state.value.isEmpty) {
      return "Please enter a name";
    }

    return null;
  }

  String _validateMemberEmail(String value) {
    FormFieldState<String> state = _memberEmailFormFieldKey.currentState;

    if(state.value.isEmpty || state.value == null || !isEmail(value)) {
      return "Please enter a valid email";
    }

    return null;
  }
}