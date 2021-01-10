import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      /** 
       * margin type EdgeInsetsGeometry & EdgeInsets extend EdgeInsetsGeometry
       * Dart allows define multiple constructors with dot notation technique
       * <> In Java, using different signature to create constructor variants
       * 
       * https://api.flutter.dev/flutter/painting/EdgeInsets-class.html
       * */

      margin: EdgeInsets.all(10),
      child: Text(
        questionText, // re-render when it received external data here
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
