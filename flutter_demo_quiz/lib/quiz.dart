import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

/**
 * Quiz is the common denominator (Parent of Question + Answer Widget)
 */
class Quiz extends StatelessWidget {
  final Function answerQuestion;
  final int questionIndex;
  final List<Map<String, Object>> questions;

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
          questions[questionIndex]['questionText'], //access specific key of Map
        ),
        // question is List which is Class|Obj => it defines map()
        // to executes function on every elements of list
        /**
         * Purpose: Instead have list of maps, we transform into list of widget
         * map() returns Interable => Use .toList() 
         * -> tell Dart convert to list because Column() Widget receives list
         * 
         * Note1: map generate new list
         * Note2: Define as because Dart does not know ['answer'] hold the list
         * Note3: Without spread operator (3 dots)  
         *  Column() only get List of invidual item not List (Answer())
         */
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          //answer is map object
          // Passing function (Address) is known as "callback" - Forward the Pointer as the funcion to Answer Widget
          return Answer(() => answerQuestion(answer['score']), answer['text']);
        }).toList()
      ],
    );
  }
}
