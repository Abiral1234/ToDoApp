import 'package:flutter/material.dart';

import '../../ListOfReminders.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  Widget build(BuildContext context) {
    return ListOfReminders();
  }
}
