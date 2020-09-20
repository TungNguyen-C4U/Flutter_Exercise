import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  // selectHandler store Pointer
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    // Container allows control the width
    return Container(
      width: double.infinity,
      child: RaisedButton(
        // static const Color black = Color(0xFF000000);
        // -Get easy access to value without creating instance
        // -Color is predifined group | Just exist as a grouping mechanism around prconfigured values.
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(answerText),
        // Register function here for an event not mean it has to be StatefulW.
        // Cuz can trigger function even if this function in other widget
        onPressed: selectHandler,
      ),
    );
  }
}
