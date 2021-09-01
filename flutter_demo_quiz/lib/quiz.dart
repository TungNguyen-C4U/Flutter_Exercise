import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

/// Quiz is the common denominator (Parent of Question + Answer Widget) ///
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
        /// Below is create concrete_instance of Question
        /// Note: concrete_instance: instance which implement all attributes
        Question(
          questions[questionIndex]['questionText'], //access specific key of Map
        ),

        /** What is usage of MAP() **
         * 1. Definition
         * map() executes a function on every elements of its List
         * map() returns Iterable
         ** [https://api.flutter.dev/flutter/dart-core/Iterable-class.html] **
         * Iterable is a collection of values | elements, that can be accessed sequentially
         
         * 2. Purpose: 
         * Instead have <list_of_maps> we transform into <list_of_widgets>
         * questions[_] is a List (also is Class|Obj) => can apply map()

         * 3. Caution:
         ** 'Widget_Column' not receive Iterable so use .toList() to reverse
         ** map() generate new list
         ** Define [as] because Dart does not know ['answer'] hold the list
         ** Column() only get List of invidual item not List of 'Widget_List'[so call Answer()s]
         ** > Use "spread operator" (3 dots)
         */
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          // 'answer' is the map object too
          /// Passing function (Address) is known as "callback"
          ///--> Forward the Pointer as the funcion to 'Answer_Widget'
          return Answer(
            () => answerQuestion(answer['score']),
            answer['text'],
          );
        }).toList()
      ],
    );
  }
}
