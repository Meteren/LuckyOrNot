import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_bank/quiz_bank.dart';
import 'question._five.dart';
import 'question_fifty.dart';
import 'question_forty.dart';
import 'question_sixty.dart';
import 'question_ten.dart';
import 'question_thirty.dart';
import 'question_twenty.dart';

class PhaseSix extends StatefulWidget {
  const PhaseSix({
    super.key, required this.questions,
  });

  final QuizBrain questions;

  @override
  State<PhaseSix> createState() => _PhaseSixState();
}

class _PhaseSixState extends State<PhaseSix> {
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
            backgroundColor: Colors.brown,
            automaticallyImplyLeading: false,
            title: const Center(child: Text('Welcome To Phase 6')),
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
                              backgroundColor: Colors.brown, // Background color
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
                          bottom: 400,
                          left: 85,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown, // Background color
                            ),
                            onPressed: 0 <= random && random < 4 && active == 0 ? () async {
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
                          bottom: 350,
                          left: 20,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown, // Background color
                            ),
                            onPressed: 4 <= random && random < 8 && active == 0 ? () async{
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
                          bottom: 350,
                          right: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown, // Background color
                            ),
                            onPressed: 8 <= random && random < 12 && active == 0 ? () async{
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
                          bottom: 250 ,
                          left: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown, // Background color
                            ),
                            onPressed: 12 <= random && random < 15 && active == 0 ? () async{
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
                          bottom: 200,
                          left: 0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown, // Background color
                            ),
                            onPressed: 15 <= random && random < 18 && active == 0 ? () async{
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
                          bottom: 200,
                          right: 0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown, // Background color
                            ),
                            onPressed: random == 18 && active == 0  ? () async{
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
                          bottom: 150,
                          left: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown, // Background color
                            ),
                            onPressed:  random == 19 && active == 0  ? () async {
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
                          bottom: 50,
                          right: 70,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
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
