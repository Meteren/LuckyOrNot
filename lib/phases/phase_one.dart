import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../components/question_point.dart';
import '../models/questions.dart';

class PhaseOne extends StatefulWidget {
  const PhaseOne({
    super.key, required this.questions,
  });

  final QuizBrain questions;

  @override
  State<PhaseOne> createState() => _PhaseOneState();
}

class _PhaseOneState extends State<PhaseOne> {
  late int random;
  late bool inactive;
  late bool finish;

  int? pointTaken;

  late int active;

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
            automaticallyImplyLeading: false,
            title: const Center(child: Text('Welcome To Phase 1')),
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
                          left: 90,
                          child: ElevatedButton(
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
                          bottom: 300,
                          left: 85,
                          child: ElevatedButton(
                            onPressed: 0 <= random && random < 10 && active == 0 ? () async {
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
                                      return QuestionPoint(questions:widget.questions,point:5);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('5 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 250,
                          left: 81,
                          child: ElevatedButton(
                            onPressed: 10 <= random && random < 20 && active == 0 ? () async{
                              setState((){
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
                                      return QuestionPoint(questions: widget.questions, point:10);
                                    }
                                ),
                              );
                            }: null,
                            child: const Text('10 points'),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          left: 69,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: finish ? () async{
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
