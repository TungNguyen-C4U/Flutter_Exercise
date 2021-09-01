import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

// void main() {
//   runApp(MyApp());
// }

//* Common denominator */
void main() => runApp(MyApp());

/// * Input ("External_Data") is received via Widget_Constructor
///=> Stateful/Stateless is rebuilt if that changes
/// * Only StatefulWidget has class properties
///----where they can update values + run build() to re-build
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
  /** COMPARE STATEFUL(Widget) vs STATELESS(Widget) **
   * In Stateful (connected): Manipulate "Internal_Data" in StateObj 
   * Other Dart class || Stateless: Can NOT update the data reflected to UI 
   *  
   * CAUTION: If there's a non-final property in Stateless -> warning @immutable
   */

// ignore: slash_for_doc_comments
  /** COMPARE FINAL vs CONST **
   * const: compile time constant 
   * <> final: runtime constant (tell value of property never change after 
   *                                    its initialization in constructor)
   
   ** COMPARE COMPILE-TIME vs RUN-TIME
   * Compile-time: Time when source code is converted into an executable code.
   * Runtime:      Time which the executable code is started running.
   
   ** Ex: **
   * Case 1:
      var dummy = const ['Hello']; // <compile time constant>
      dummy.add('Max');            // CompileError because change value to const
      dummy = [];                  // Return []

   * Case 2:
      var dummy = ['Hello'];
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
   * BUT efficiently it has mechanism to find out what need to re-drawn
   * -> Wrap the code changes the "InternalData" which reflected UI in setState()
   * Ex: _questionIndex control (reflect) which question shows in UI
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
