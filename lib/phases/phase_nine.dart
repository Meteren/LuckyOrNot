import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../components/question_point.dart';
import '../repositories/questions_repo.dart';

class PhaseNine extends StatefulWidget {
  const PhaseNine({
    super.key, required this.questions,
  });

  final QuizBrain questions;

  @override
  State<PhaseNine> createState() => _PhaseNineState();
}

class _PhaseNineState extends State<PhaseNine> {
  late int random;
  late bool inactive;

  int? pointTaken;

  late int active;

  late bool finish;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inactive = false;
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
            backgroundColor: Colors.pinkAccent,
            automaticallyImplyLeading: false,
            title: const Center(child: Text('Welcome To Phase 9')),
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
                          right: 0,
                          left: 0,
                          child: FittedBox(
                            child: Text
                              ('Press -Decide- button to decide your fate'),
                          ),
                        ),
                        Positioned(
                          top: 70,
                          left: 92,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent, // Background color
                            ),
                            onPressed: inactive ? null : () {
                              setState( () {
                                random = Random().nextInt(20);
                                inactive = true;
                              });
                            },
                            child: const Text('Decide'),
                          ),
                        ),
                        Positioned(
                          bottom: 420,
                          left: 88,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent, // Background color
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
                                      return  QuestionPoint(questions:widget.questions,point: 5);
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
                              backgroundColor: Colors.pinkAccent, // Background color
                            ),
                            onPressed: 3 <= random && random < 6 && active == 0 ? () async{
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
                                      return  QuestionPoint(questions: widget.questions,point:10);
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
                              backgroundColor: Colors.pinkAccent, // Background color
                            ),
                            onPressed: 6 <= random && random < 9 && active == 0 ? () async{
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
                                      return  QuestionPoint(questions: widget.questions,point: 20);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('20 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 320,
                          left: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent, // Background color
                            ),
                            onPressed: 9 <= random && random < 12 && active == 0 ? () async{
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
                                      return QuestionPoint(questions: widget.questions,point: 30);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('30 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 320,
                          right: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent, // Background color
                            ),
                            onPressed: 12 <= random && random < 14 && active == 0 ? () async{
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
                                      return QuestionPoint(questions: widget.questions,point: 40);
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
                              backgroundColor: Colors.pinkAccent, // Background color
                            ),
                            onPressed: 14 <= random && random < 16 && active == 0  ? () async{
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
                                      return QuestionPoint(questions: widget.questions,point: 50);
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
                              backgroundColor: Colors.pinkAccent, // Background color
                            ),
                            onPressed: random == 16 && active == 0  ? () async {
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
                                      return  QuestionPoint(questions:widget.questions,point: 60);
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
                              backgroundColor: Colors.pinkAccent, // Background color
                            ),
                            onPressed: random == 17 && active == 0  ? () async {
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
                                      return  QuestionPoint(questions:widget.questions,point: 70);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('70 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 170,
                          left: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent, // Background color
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
                                      return  QuestionPoint(questions:widget.questions,point: 80);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('80 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 120,
                          left: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent, // Background color
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
                                      return  QuestionPoint(questions:widget.questions,point: 90);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('90 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          left: 69,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
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
