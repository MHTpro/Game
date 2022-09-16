import 'dart:math';

import 'package:flutter/material.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyGame(),
    );
  }
}

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  List<int> theNumbers = List.generate(6, (index) => Random().nextInt(200));

  int eachNumber = 0;
  int index = 0;
  int wrongMove = 0;
  bool gameOver = false;
  int finishGame = 0;

  showSnack(BuildContext context, String txt, Color clr) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10.0),
        content: Text(
          txt,
          style: TextStyle(
            fontSize: 25.0,
            color: clr,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(
          seconds: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return gameOver
        ? Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Game\nOver",
                    style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 100.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Your wrong awnser is 3.",
                    style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 200.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const MyGame();
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    "Again",
                    style: TextStyle(
                      fontSize: 50.0,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 50.0,
                      right: 5.0,
                      child: Text(
                        "$theNumbers",
                        style: TextStyle(
                          backgroundColor: Colors.grey.shade300,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      left: 10.0,
                      child: Text(
                        "Wrong Move: $wrongMove",
                        style: TextStyle(
                          backgroundColor: Colors.grey.shade300,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10.0,
                      left: 130.0,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(
                            () {
                              theNumbers = List.generate(
                                6,
                                (index) => Random().nextInt(200),
                              );

                              eachNumber = 0;
                              index = 0;
                              wrongMove = 0;
                              gameOver = false;
                              finishGame = 0;
                            },
                          );
                          showSnack(
                            context,
                            "Game Reset",
                            Colors.blue,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                        ),
                        child: const Text(
                          "Reset",
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Draggable(
                          data: eachNumber = theNumbers[index],
                          childWhenDragging: Opacity(
                            opacity: 0.5,
                            child: Container(
                              height: 130.0,
                              width: 130.0,
                              color: Colors.red[900],
                              alignment: Alignment.center,
                              child: Text(
                                "${eachNumber = theNumbers[index]}",
                                style: const TextStyle(
                                  fontSize: 35.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          feedback: Container(
                            height: 130.0,
                            width: 130.0,
                            color: Colors.red[900],
                            alignment: Alignment.center,
                            child: Text(
                              "$eachNumber",
                              style: const TextStyle(
                                fontSize: 35.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          child: Container(
                            height: 130.0,
                            width: 130.0,
                            color: Colors.red[900],
                            alignment: Alignment.center,
                            child: Text(
                              "$eachNumber",
                              style: const TextStyle(
                                fontSize: 35.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            DragTarget(
                              builder: (
                                BuildContext context,
                                List<Object?> candidateData,
                                List<dynamic> rejectedData,
                              ) {
                                return Container(
                                  height: 130.0,
                                  width: 130.0,
                                  color: Colors.blue[900],
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Odd",
                                    style: TextStyle(
                                      fontSize: 35.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                              onWillAccept: (data) {
                                return true;
                              },
                              onAccept: (int data) {
                                if (index < 5) {
                                  setState(
                                    () {
                                      index++;
                                    },
                                  );
                                }
                                if (data % 2 == 0) {
                                  showSnack(
                                    context,
                                    "Wrong",
                                    Colors.red,
                                  );
                                  setState(
                                    () {
                                      wrongMove++;
                                    },
                                  );
                                } else {
                                  showSnack(
                                    context,
                                    "Correct",
                                    Colors.green,
                                  );
                                }
                                if (wrongMove == 3) {
                                  gameOver = true;
                                }
                                finishGame++;
                                if (finishGame == 6) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return const FinishGame();
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                            DragTarget(
                              builder: (
                                BuildContext context,
                                List<Object?> candidateData,
                                List<dynamic> rejectedData,
                              ) {
                                return Container(
                                  height: 130.0,
                                  width: 130.0,
                                  color: Colors.green[900],
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Even",
                                    style: TextStyle(
                                      fontSize: 35.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                              onWillAccept: (data) {
                                return true;
                              },
                              onAccept: (int data) {
                                if (index < 5) {
                                  setState(
                                    () {
                                      index++;
                                    },
                                  );
                                }
                                if (data % 2 == 0) {
                                  showSnack(
                                    context,
                                    "Correct",
                                    Colors.green,
                                  );
                                } else {
                                  showSnack(
                                    context,
                                    "Wrong",
                                    Colors.red,
                                  );
                                  setState(
                                    () {
                                      wrongMove++;
                                    },
                                  );
                                }
                                if (wrongMove == 3) {
                                  gameOver = true;
                                }
                                finishGame++;
                                if (finishGame == 6) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return const FinishGame();
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class FinishGame extends StatefulWidget {
  const FinishGame({super.key});

  @override
  State<FinishGame> createState() => _FinishGameState();
}

class _FinishGameState extends State<FinishGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              "Finish\nGame",
              style: TextStyle(
                color: Colors.green[900],
                fontSize: 100.0,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            ),
          ),
          const SizedBox(
            height: 200.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const MyGame();
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text(
              "Again",
              style: TextStyle(
                fontSize: 50.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
