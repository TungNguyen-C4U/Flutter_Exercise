// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('showMBS_by Container'),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                        // height: 200, #make  RenderFlex overflow <n> pixels
                        // color: Colors.amber,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(
                                  '''Shows a modal material design bottom sheet.

A modal bottom sheet is an alternative to a menu or a dialog and prevents the user from interacting with the rest of the app.

A closely related widget is a persistent bottom sheet, which shows information that supplements the primary content of the app without preventing the use from interacting with the app. Persistent bottom sheets can be created and displayed with the showBottomSheet function or the ScaffoldState.showBottomSheet method.

The context argument is used to look up the Navigator and Theme for the bottom sheet. It is only used when the method is called. Its corresponding widget can be safely removed from the tree before the bottom sheet is closed.

The isScrollControlled parameter specifies whether this is a route for a bottom sheet that will utilize DraggableScrollableSheet. If you wish to have a bottom sheet that has a scrollable child such as a ListView or a GridView and have the bottom sheet be draggable, you should set this parameter to true.

The useRootNavigator parameter ensures that the root navigator is used to display the BottomSheet when set to true. This is useful in the case that a modal BottomSheet needs to be displayed above all other content but the caller is inside another Navigator.

The isDismissible parameter specifies whether the bottom sheet will be dismissed when user taps on the scrim.

The enableDrag parameter specifies whether the bottom sheet can be dragged up and down and dismissed by swiping downwards.

The optional backgroundColor, elevation, shape, clipBehavior and transitionAnimationController parameters can be passed in to customize the appearance and behavior of modal bottom sheets.

The transitionAnimationController controls the bottom sheet's entrance and exit animations if provided.

The optional routeSettings parameter sets the RouteSettings of the modal bottom sheet sheet. This is particularly useful in the case that a user wants to observe PopupRoutes within a NavigatorObserver.

Returns a Future that resolves to the value (if any) that was passed to Navigator.pop when the modal bottom sheet was closed.'''),
                              ElevatedButton(
                                child: const Text('Close BottomSheet'),
                                onPressed: () => Navigator.pop(context),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            ElevatedButton(
              child: const Text('showMBS_by GestureDetecture'),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {}, // Do nothing, avoid sheet closed
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Modal BottomSheet'),
                            ElevatedButton(
                              child: const Text('Close BottomSheet'),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            // Sheet will close when touch on anything
            ElevatedButton(
              child: const Text('showMBS_by Nothing rather than content'),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Modal BottomSheet'),
                          ElevatedButton(
                            child: const Text('Close BottomSheet'),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),

            ElevatedButton(
              child: const Text('showMBS clone from tutorial project'),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Card(
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(labelText: 'Title'),
                            onSubmitted: (_) => {},
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Amount'),
                            keyboardType: TextInputType.number,
                            onSubmitted: (_) => {},
                          ),
                          RaisedButton(
                            child: Text('Add Transaction'),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
