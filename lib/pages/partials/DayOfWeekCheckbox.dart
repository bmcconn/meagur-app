import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DayOfWeekCheckbox extends StatelessWidget {

  DayOfWeekCheckbox({Key key, @required this.isChecked, this.day, @required this.changed}) : super(key: key);

  final bool isChecked;
  final String day;
  final ValueChanged<bool> changed;

  void _handleTap(bool value) {
    changed(!isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      flex: 1,
      child: new CheckboxListTile(
        value: isChecked,
        title: new Text(day),
        onChanged: _handleTap,
        dense: true,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
