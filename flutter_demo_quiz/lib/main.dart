import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';
// void main() {
//   runApp(MyApp());
// }

//* Common denominator */
void main() => runApp(MyApp());

/// * Input (External_Data) is received via Widget_Constructor
///=> Stateful/Stateless is rebuilt if that changes
/// * Only StatefulWidget has class properties
///----where they can update values + re-run build()
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState(); // returned StateObj
}

// ignore: slash_for_doc_comments
/**
   * Generic class State<> (material.dart) has Pointer of its Widget
   * -> create connection, which tell this is its Internal_State (1)
   * Input changed -> Widget re-created
   * >< State, attached to its Widget-element in UI, "technically" not re-created
   */
class _MyAppState extends State<MyApp> {
// ignore: slash_for_doc_comments
/**
 * Manipulate Internal_Data in StateObj == in StatefulWidget (connected)
 * BUT it can update the data reflected to UI <> other Dart class || Stateless
 * If there is non-final property in Stateless -> warning @immutable
 */

// ignore: slash_for_doc_comments
/**
 * final: tell value of property never change after its initialization in constructor
 * const: compile time constant <> final: runtime constant
 * Ex: 
 * Case 1:
  var dummy = const ['Hello']; // <compile time constant>
  dummy.add('Max');            //Return Error when compling because change value to const 
  dummy = [];                  // Return []

 * Case 2:
  var dummy = ['Max'];
  dummy.add('Max');            //Return ['Hello','Max']

 * Case 3:
  const questions = ['Hello']
  questions = [];              // Return Error: Can't assign to the const var
 */


  final _questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 3},
        {'text': 'Snake', 'score': 11},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lion', 'score': 9},
      ],
    },
    {
      'questionText': 'Who\'s your favorite instructor?',
      'answers': [
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

   // ignore: slash_for_doc_comments
   /**
     * Flutter is good at not taking every tap on screen as an indicator to re-render everything.
     * - We tell Flutter state changed and re-render this widget by call its build() 
     * BUT efficiently it has mechanism to find out what need to redrawn
     *** -> Wrap the code changes the Internal_Data, which reflected UI in setState()
     * Ex: _questionIndex control which question show
     */
  void _answerQuestion(int score) {
    _totalScore += score;
    
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
