import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../components/question_point.dart';
import '../models/questions.dart';

class PhaseSeven extends StatefulWidget {
  const PhaseSeven({
    super.key, required this.questions,
  });

  final QuizBrain questions;

  @override
  State<PhaseSeven> createState() => _PhaseSevenState();
}

class _PhaseSevenState extends State<PhaseSeven> {
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
            backgroundColor: Colors.tealAccent,
            automaticallyImplyLeading: false,
            title: const Center(child: Text('Welcome To Phase 7')),
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
                          child: Text
                            ('Press -Decide- button to decide your fate'),
                        ),
                        Positioned(
                          top: 70,
                          left: 90,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent, // Background color
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
                          bottom: 400,
                          left: 85,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent, // Background color
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
                                      return  QuestionPoint(questions:widget.questions,point: 5);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('5 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 350,
                          left: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent, // Background color
                            ),
                            onPressed: 4 <= random && random < 7 && active == 0 ? () async{
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
                                      return  QuestionPoint(questions: widget.questions,point: 10);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('10 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 300,
                          left: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent, // Background color
                            ),
                            onPressed: 7 <= random && random < 10 && active == 0 ? () async{
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
                          bottom: 300,
                          right: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent, // Background color
                            ),
                            onPressed: 10 <= random && random < 13 && active == 0 ? () async{
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
                                      return QuestionPoint(questions: widget.questions, point:30 );
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('30 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 250,
                          left: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent, // Background color
                            ),
                            onPressed: 13 <= random && random < 16 && active == 0 ? () async{
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
                                      return QuestionPoint(questions: widget.questions, point: 40);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('40 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 200,
                          left: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent, // Background color
                            ),
                            onPressed: 16 <= random && random < 18 && active == 0  ? () async{
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
                          bottom: 200,
                          right: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent, // Background color
                            ),
                            onPressed: random == 18 && active == 0  ? () async {
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
                          bottom: 150,
                          left: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent, // Background color
                            ),
                            onPressed: random == 19 && active == 0  ? () async {
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
                          bottom: 50,
                          left: 69,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent,
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
