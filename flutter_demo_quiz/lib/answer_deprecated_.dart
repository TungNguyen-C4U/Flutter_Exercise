import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  // selectHandler store Pointer to the basic _answerQuestion() [Not scoring]
  final Function selectHandler;

  Answer(this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              // static const Color black = Color(0xFF000000);
              // -Get easy access to value without creating instance
              // -Color is predifined group | Just exist as a grouping mechanism around pre-configured values.
              color: Colors.white,
              fontSize: 20,
              backgroundColor: Colors.blue,
            ),
          ),
          onPressed: selectHandler,
          child: null,
        ));
  }
}
