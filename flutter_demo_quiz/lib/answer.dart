import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  // selectHandler store Pointer
  final Function selectHandler;
  final String answerText;

  Answer(
    this.selectHandler,
    this.answerText,
  );

  @override
  Widget build(BuildContext context) {
    /**
     * Use 'Container_Widget' allows control the width
     * 'onPressed' takes (register) func for an event but not mean it has to be StatefulW.
     * Because it can trigger func even if this func in other Widget
     *  */
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(answerText),
        onPressed: selectHandler,
      ),
    );
  }
}
