import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';
/**
 * Quiz is the common denominator (Parent of Question + Answer Widget)
 */
class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Below is create concrete instance of Question
        Question(
          questions[questionIndex]['questionText'],
        ),
        // question is List => Class | Object => Class defines a map method
        /**
         * Purpose: Instead have list of maps, we transform into list of widget
         * map returns Interable => .toList() - tell Dart convert value to list
         * Note1: map generate new list
         * Note2: Define as because Dart does not know answer key hold the list
         */
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>).map((answer) {
          // Passing function (Address) is known as "callback" - Forward the Pointer as the funcion to Answer Widget
          return Answer(() => answerQuestion(answer['score']), answer['text']);
        }).toList()
      ],
    );
  }
}
