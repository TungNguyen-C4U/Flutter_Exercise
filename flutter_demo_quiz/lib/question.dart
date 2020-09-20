import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      /** 
       * "margin" takes EdgeInsetsGeometry value 
       * - EdgeInsets extend it -> init EdgeInsets auto get EdgeInsetsGeometry obj
       * 
       * Dart allows define multiple constructors with dot notation technique
       * - In Java, using different signature to create constructor variants
       * */ 

      margin: EdgeInsets.all(10),
      // It is True that (Text) Widget re-render when it received external data - automatically call build() here
      child: Text(
        questionText,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
