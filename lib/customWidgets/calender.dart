import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
class CalenderBox extends StatefulWidget {
  @override
  _CalenderBoxState createState() => _CalenderBoxState();
}

class _CalenderBoxState extends State<CalenderBox> {
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: Colors.black,
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            // New date selected
            setState(() {
              _selectedValue = date;
            });
          },
        ),
      ],
    );
  }
}
