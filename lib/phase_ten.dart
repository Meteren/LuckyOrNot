import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_bank/quiz_bank.dart';
import 'question._five.dart';
import 'question_eighty.dart';
import 'question_fifty.dart';
import 'question_forty.dart';
import 'question_ninety.dart';
import 'question_seventy.dart';
import 'question_sixty.dart';
import 'question_ten.dart';
import 'question_thirty.dart';
import 'question_twenty.dart';
import 'questions_one_hundred.dart';

class PhaseTen extends StatefulWidget {
  const PhaseTen({
    super.key, required this.questions,
  });

  final QuizBrain questions;

  @override
  State<PhaseTen> createState() => _PhaseTenState();
}

class _PhaseTenState extends State<PhaseTen> {
  late int random;
  late bool deactive;

  int? pointTaken;

  late int active;

  late bool finish;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deactive = false;
    random = -1;
    active = 0;
    finish = false;
  }

  @override
  Widget build(BuildContext context) {
    bool ctrl = false;
    return WillPopScope(
      onWillPop: ()async{
        if (ctrl == false) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Center(child: Text("Use only on screen buttons to go back.")),
                duration: Duration(seconds: 2),
              )
          );
          ctrl = true;
        }
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            backgroundColor: Colors.cyanAccent,
            automaticallyImplyLeading: false,
            title: const Center(child: Text('Welcome To Phase 10')),
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                    height: 603.4,
                    width: 255,
                    child: Stack(
                      children: [
                        const Positioned(
                          top: 50,
                          child: Text
                            ('Press -Decide- button to decide your fate'),
                        ),
                        Positioned(
                          top: 70,
                          left: 90,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent, // Background color
                            ),
                            onPressed: deactive ? null : () {
                              setState( () {
                                random = Random().nextInt(20);
                                deactive = true;
                              });
                            },
                            child: const Text('Decide'),
                          ),
                        ),
                        Positioned(
                          bottom: 420,
                          left: 85,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent, // Background color
                            ),
                            onPressed: 0 <= random && random < 3 && active == 0 ? () async {
                              setState(() {
                                active++;
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    finish = true;
                                  });
                                });
                              });
                              pointTaken = await Navigator.of(context).push<int>(
                                MaterialPageRoute(
                                    builder: (context){
                                      return  QuestionFive(questions:widget.questions);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('5 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 370,
                          left: 0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent, // Background color
                            ),
                            onPressed: 3 <= random && random < 5 && active == 0 ? () async{
                              setState(() {
                                active++;
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    finish = true;
                                  });
                                });
                              });
                              pointTaken = await Navigator.of(context).push<int>(
                                MaterialPageRoute(
                                    builder: (context){
                                      return  QuestionTen(questions: widget.questions);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('10 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 370,
                          right: 0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent, // Background color
                            ),
                            onPressed: 5 <= random && random < 7  && active == 0 ? () async{
                              setState(() {
                                active++;
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    finish = true;
                                  });
                                });
                              });
                              pointTaken = await Navigator.of(context).push<int>(
                                MaterialPageRoute(
                                    builder: (context){
                                      return  QuestionTwenty(questions: widget.questions);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('20 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 320,
                          right: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent, // Background color
                            ),
                            onPressed: 7 <= random && random < 9 && active == 0 ? () async{
                              setState(() {
                                active++;
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    finish = true;
                                  });
                                });
                              });
                              pointTaken = await Navigator.of(context).push<int>(
                                MaterialPageRoute(
                                    builder: (context){
                                      return QuestionThirty(questions: widget.questions);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('30 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 320,
                          left: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent, // Background color
                            ),
                            onPressed: 9 <= random && random < 11 && active == 0 ? () async{
                              setState(() {
                                active++;
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    finish = true;
                                  });
                                });
                              });
                              pointTaken = await Navigator.of(context).push<int>(
                                MaterialPageRoute(
                                    builder: (context){
                                      return QuestionFourty(questions: widget.questions);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('40 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 270,
                          left: 85,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent, // Background color
                            ),
                            onPressed: 11 <= random && random < 13 && active == 0  ? () async{
                              setState(() {
                                active++;
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    finish = true;
                                  });
                                });
                              });
                              pointTaken = await Navigator.of(context).push<int>(
                                MaterialPageRoute(
                                    builder: (context){
                                      return QuestionFifty(questions: widget.questions);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('50 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 220,
                          left: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent, // Background color
                            ),
                            onPressed: 13 <= random && random < 15 && active == 0  ? () async {
                              setState(() {
                                active++;
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    finish = true;
                                  });
                                });
                              });
                              pointTaken = await Navigator.of(context).push<int>(
                                MaterialPageRoute(
                                    builder: (context){
                                      return QuestionSixty(questions:widget.questions);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('60 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 220,
                          right: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent, // Background color
                            ),
                            onPressed: 15 <= random && random < 17 && active == 0  ? () async {
                              setState(() {
                                active++;
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    finish = true;
                                  });
                                });
                              });
                              pointTaken = await Navigator.of(context).push<int>(
                                MaterialPageRoute(
                                    builder: (context){
                                      return QuestionSeventy(questions:widget.questions);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('70 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 170,
                          left: 0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent, // Background color
                            ),
                            onPressed: random == 17 && active == 0 ? () async {
                              setState(() {
                                active++;
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    finish = true;
                                  });
                                });
                              });
                              pointTaken = await Navigator.of(context).push<int>(
                                MaterialPageRoute(
                                    builder: (context){
                                      return QuestionEighty(questions:widget.questions);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('80 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 170,
                          right: 0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent, // Background color
                            ),
                            onPressed: random == 18 && active == 0 ? () async {
                              setState(() {
                                active++;
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    finish = true;
                                  });
                                });
                              });
                              pointTaken = await Navigator.of(context).push<int>(
                                MaterialPageRoute(
                                    builder: (context){
                                      return QuestionNinety(questions:widget.questions);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('90 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 120,
                          left: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent, // Background color
                            ),
                            onPressed: random == 19 && active == 0 ? () async {
                              setState(() {
                                active++;
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    finish = true;
                                  });
                                });
                              });
                              pointTaken = await Navigator.of(context).push<int>(
                                MaterialPageRoute(
                                    builder: (context){
                                      return QuestionOneHundred(questions:widget.questions);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('100 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          right: 70,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent,
                            ),
                            onPressed: finish ? () {
                              Navigator.of(context).pop<int>(pointTaken);
                            }:null,
                            child: const Text('Finish Phase'),
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          )
      ),
    );
  }
}
