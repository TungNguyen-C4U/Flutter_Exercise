import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';
// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

// InputData (ExternalDate) is received via constructor of a Widget and make Widget Stateful/Stateless is rebuilt if that changes
// But only StatefulWidgets can have class properties where they can update values + re-run build().
class MyApp extends StatefulWidget {
  // createState returns State Object which is connected to StatefulWidget (Pointer inside <>)
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

/**
 * State is imported from material.dart | 
 * - Also is generic class so we can add Pointer of its Widget inside" < > " to create connection, which tell this is its InternalState (1)
 * Basically Widget itself can recreated when the external data changes BUT State, attached to its Widget-element in UI, technically not recreated
 */
// Note: Manage internal data in StatefulWidget - actually is in State Object which connected to StatefulWidget
// ---(can do it in other Dart class or StatelessWidget afterall - but only with Stateful can update the data reflected to UI)
// ---> That is why in StatelessWidget if there is property it will warning that class is immutable but property can change so give it "final" keyword
//----> So final tell value of property never change after its initialization in constructor

class _MyAppState extends State<MyApp> {
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
    // var aBool = true;
    // aBool = false;

    _totalScore += score;

    /**
     * Since Flutter is good at not taking every tap on screen as an indicator to re-render everything.
     * - We tell flutter state changed and re-render this widget by call build() of its BUT efficiently it has mechanism to find out what need to redrawn
     * => Wrap code change the internal data which reflected UI (Like questionIndex control which question show)
     * setState is method of inherit State class
     */
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);

    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    // var dummy = const ['Hello'];
    // dummy.add('Max');
    // print(dummy);
    // dummy = [];
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
