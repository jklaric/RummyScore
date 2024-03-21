import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppScreen());
}

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int player1Score = 0;
  int player2Score = 0;
  List<int> scoreHistory =
      []; //History of who won last so we can undo; Player 1 is symbolised with a 1, Player 2 with a 2

  void undo() {
    if (scoreHistory.isEmpty) {
      return;
    } else if (scoreHistory.last == 1 && player1Score > 0) {
      player1Score--;
      scoreHistory.removeLast();
    } else if (scoreHistory.last == 2 && player2Score > 0) {
      player2Score--;
      scoreHistory.removeLast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remi Score',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent[700],
          title: Text('Remi Score',
          style: TextStyle(
            fontFamily: 'Pridi',
            color: Colors.black87,
            fontSize: 25.0,
            fontWeight: FontWeight.w600,)
          ),
        ),
        body:
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backdrop3.png"),
              fit: BoxFit.contain,
              repeat: ImageRepeat.repeat,
            ),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 100.0),
                    width: 250.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.black87.withOpacity(1.0),
                          Colors.transparent,
                          Colors.black87.withOpacity(1.0),
                        ],
                        stops: [0.1, 0.5, 0.9],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<CircleBorder>(
                            CircleBorder()),
                          ),
                          onPressed: () {
                            setState(() {
                              player1Score++;
                              scoreHistory.add(1);
                            });
                          },
                          child: Icon(CupertinoIcons.suit_spade_fill, color: Colors.black87),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50.0),
                          child: Text('$player1Score', style: TextStyle(
                            fontFamily: 'Pridi',
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w500,)),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 250.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.black87.withOpacity(1.0),
                          Colors.transparent,
                          Colors.black87.withOpacity(1.0),
                        ],
                        stops: [0.1, 0.5, 0.9],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<CircleBorder>(
                                  CircleBorder()),
                            ),
                          onPressed: () {
                            setState(() {
                              player2Score++;
                              scoreHistory.add(2);
                            });
                          },
                          child: Icon(CupertinoIcons.suit_heart_fill, color: Colors.redAccent[700])
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50.0),
                          child: Text('$player2Score', style: TextStyle(
                            fontFamily: 'Pridi',
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w500,)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.redAccent[700],
                    onPressed: () {
                      setState(() {
                        player1Score = 0;
                        player2Score = 0;
                        scoreHistory.clear();
                      });
                    },
                    child: Icon(Icons.autorenew, color: Colors.black87, size: 30.0),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.redAccent[700],
                    onPressed: () {
                      setState(() {
                        undo();
                      });
                    },
                    child: Icon(Icons.undo, color: Colors.black87, size: 25.0),
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
