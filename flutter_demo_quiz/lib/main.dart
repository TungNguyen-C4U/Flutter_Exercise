import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';
// void main() {
//   runApp(MyApp());
// }

//* Common denominator */
void main() => runApp(MyApp());

// Input (also External_Data) is received via Widget_Constructor
// -> Stateful/Stateless is rebuilt if that changes
// But only StatefulWidgets can have class properties where they can update values + re-run build()

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
 * Manipulate InternalData in State_Object == in StatefulWidget (connected)
 * BUT it can update the data reflected to UI <> other Dart class || Stateless
 * There is property in Stateless -> warning @immutable
 * -> final: tell value of property never change after its initialization in constructor
 * However property can change after all !
 */
//// final: runtime constant <> const: compile time constant
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

  void _answerQuestion(int score) {
    _totalScore += score;

    /**
     * Flutter is good at not taking every tap on screen as an indicator to re-render everything.
     * - We tell Flutter state changed and re-render this widget by call build() of its 
     * BUT efficiently it has mechanism to find out what need to redrawn
     *** -> Wrap the code change the internal data which reflected UI 
     * Ex: _questionIndex control which question show)
     */
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
    // var dummy = const ['Hello'];
    // dummy.add('Max'); //Error when compling because change value to const (comile time constant)

    // dummy = []; //But this will allow
    // questions = []; // does not work if questions is a const

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
