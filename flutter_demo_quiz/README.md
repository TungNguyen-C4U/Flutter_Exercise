# flutter_quiz
## Overview

This project is using demo for some technics which list below.

## Learning Obects
- Stateless_Widget and Stateful_Widget.
> Only properties in StatefulWidget can updated after re-build.
> Also update the data in StatefulWidget can reflect to UI.
> warning @immutable if there is non-final variable in Stateless Class.


- Enum and Constructor Variants.
> Define multiple constructors by using dot notation technique.
> Note that in Java, using different signature to create constructor variants.

- map(), Iterable, Spread operator, Callback technique.
```sh
(questions[questionIndex]['answers'] as List<Map<String, Object>>)
    .map((answer) {
  return Answer(() => answerQuestion(answer['score']), answer['text']);
}).toList()
```
> map() returns Iterable >.toList() to convert (Widget_Column not receive Iterable).
> Iterable is a collection of values | elements, that can be accessed sequentially.
> Define [as] because Dart does not know ['answer'] hold the list
> Passing Address() is known as [Callback]

