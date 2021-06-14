import 'package:flutter/material.dart';

Widget info({required IconData icon, required String text}) {
  Color color = Colors.grey;
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 60, color: color),
        SizedBox(height: 5),
        Text(text, style: TextStyle(color: color))
      ],
    ),
  );
}
