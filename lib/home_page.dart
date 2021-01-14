import 'dart:async';
import 'package:flappy_bird_game/barrier.dart';
import 'package:flappy_bird_game/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  bool gameHasStarted = false;
  static double barrierXOne = 1.1;
  double barrierXTwo = barrierXOne + 2;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(
      Duration(milliseconds: 50),
      (timer) {
        setState(() {
          if(barrierXOne < -2.1){
            barrierXOne += 4.1;
          } else {
            barrierXOne -= 0.05;
          }
          if(barrierXTwo < -2.1){
            barrierXTwo += 4.1;
          } else {
            barrierXTwo -= 0.05;
          }
        });
        time += 0.04;
        height = -4.9 * time * time + 2 * time;
        setState(() {
          birdYAxis = initialHeight - height;
        });
        if (birdYAxis > .93) {
          timer.cancel();
          gameHasStarted = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(-0.25, birdYAxis),
                    duration: Duration(microseconds: 20),
                    color: Colors.blue,
                    child: MyBird(),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: gameHasStarted
                        ? Text("")
                        : Text(
                            "TAP TO  PLAY",
                            style: TextStyle(fontSize: 35, color: Colors.white),
                          ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(barrierXOne, 1.1),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(barrierXOne, -1.1),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(barrierXTwo, 1.1),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(barrierXTwo, -1.1),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Score",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                        SizedBox(height: 10),
                        Text(
                          "0",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Score",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                        SizedBox(height: 10),
                        Text(
                          "10",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
