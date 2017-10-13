import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatelessWidget {
  final String labelText;
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> selectTime;

  const TimePicker({
    Key key,
    this.labelText,
    this.selectedTime,
    this.selectTime
  }) : super(key: key);

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      selectTime(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return new Expanded(
      child: new _InputDropdown(
        labelText: labelText,
        valueText: new TimeOfDay(hour: selectedTime.hour, minute: selectedTime.minute).format(context),
        valueStyle: valueStyle,
        onPressed: () { _selectTime(context); },
      ),
    );
  }
}

class _InputDropdown extends StatelessWidget {
  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  const _InputDropdown({
    Key key,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed,
    this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle,),
            new Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700: Colors.white70,
            )
          ],
        ),
      ),
    );
  }


}