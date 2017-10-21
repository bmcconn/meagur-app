import 'package:meagur/models/teams/members/TeamMember.dart';

class TeamMemberList {
  List<TeamMember> _members = [];

  TeamMemberList(this._members);

  List<TeamMember> getTeamMembers() => _members;

  void setTeamMembers(List<TeamMember> members) => _members = members;

  TeamMemberList.fromMap(Map<String, dynamic> map) {
    map['data'].forEach((member) {
      TeamMember memberToAdd = new TeamMember.fromMap(member);
      _members.add(memberToAdd);
    });
  }
}