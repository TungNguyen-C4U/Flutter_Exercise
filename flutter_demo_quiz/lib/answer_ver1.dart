import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  // selectHandler store Pointer to the basic _answerQuestion() [Not scoring]
  final Function selectHandler;

  Answer(this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: selectHandler,
      ),
    );
  }
}
