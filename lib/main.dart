import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_bank/quiz_bank.dart';
import 'how_to_play.dart';
import 'phase_eight.dart';
import 'phase_five.dart';
import 'phase_four.dart';
import 'phase_nine.dart';
import 'phase_one.dart';
import 'phase_seven.dart';
import 'phase_six.dart';
import 'phase_ten.dart';
import 'phase_three.dart';
import 'phase_two.dart';
import 'restart_app.dart';

void main() {
  runApp(const RestartWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late QuizBrain mainQuestions;

  late List<int?> sumPoints;

  late int active;

  int? sum = 0;

  late int i;

  int? pointTaken;

  int? a,b,c,d,e,f,g,h,j,k;

  late int activePrimary;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainQuestions = QuizBrain();
    active = 11;
    sumPoints = [];
    i = -1;
    activePrimary = 0;
  }

  void calcScore(List<int?> sumPoints) {
    int? sum = 0;
    for (int i = 0; i < sumPoints.length; i++) {
      sum = sum! + sumPoints[i]!;
    }
    this.sum = sum;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: FittedBox(
                alignment: Alignment.center,
                child: Text('Scores',
                  style: TextStyle(color: Colors.white),
                  textScaleFactor: 0.5,
                ),
              ),
            ),
            if(i==0 || i ==1 || i == 2 || i == 3 || i == 4 || i == 5 || i == 6 ||
            i==7 || i ==8 || i == 9 )
             Text('Phase 1 earned point(s): $a'),
            if( i ==1 || i == 2 || i == 3 || i == 4 || i == 5 || i == 6 ||
                i==7 || i ==8 || i == 9 )
              Text('Phase 2 earned point(s): $b'),
            if(  i == 2 || i == 3 || i == 4 || i == 5 || i == 6 ||
                i==7 || i ==8 || i == 9 )
              Text('Phase 3 earned point(s): $c'),
            if( i == 3 || i == 4 || i == 5 || i == 6 ||
                i==7 || i ==8 || i == 9 )
              Text('Phase 4 earned point(s): $d'),
            if(  i == 4 || i == 5 || i == 6 ||
                i==7 || i ==8 || i == 9 )
              Text('Phase 5 earned point(s): $e'),
            if( i == 5 || i == 6 || i==7 || i ==8 || i == 9 )
              Text('Phase 6 earned point(s): $f'),
            if( i == 6 || i==7 || i ==8 || i == 9 )
              Text('Phase 7 earned point(s): $g'),
            if( i==7 || i ==8 || i == 9)
              Text('Phase 8 earned point(s): $h'),
            if( i ==8 || i == 9)
              Text('Phase 9 earned point(s): $j'),
            if( i == 9)
              Text('Phase 10 earned point(s): $k'),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color
                ),
                onPressed: active % 11 == 10
                    ? () {
                  calcScore(sumPoints);
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Score:'),
                      content: Text('Your score is $sum'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
                    : null,
                child: const Text('Calculate Score')),
          ],
        ),
      ),
      body: Center(
        child: SizedBox.expand(
          //width: 411,
          //height: 683.4,
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 603.4,
                      width: 255,
                      child: Stack(
                        children: [
                          const Positioned(
                            left: 10,
                            right:10,
                            bottom: 450,
                            child: FittedBox(
                              child:
                                Text('Welcome',
                                  textScaleFactor: 4)
                            ),
                          ),
                          Positioned(
                            left: 75,
                            right: 75,
                            top: 175,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black, // Background color
                                ),
                                onPressed: activePrimary == 0
                                    ? ()  {
                                  setState(() {
                                    activePrimary++;
                                  });

                                }
                                    : null,
                                child: const Text('Start Game')),
                          ),

                          Positioned(
                            left: 35,
                            bottom: 330,
                            child: ElevatedButton(
                                onPressed: active % 11 == 0 && activePrimary == 1
                                    ? () async {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    setState(() {
                                      active++;
                                    });
                                  });
                                  pointTaken =
                                  await Navigator.of(context).push<int>(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PhaseOne(questions: mainQuestions);
                                      },
                                    ),
                                  );
                                  sumPoints.add(pointTaken);
                                  setState(() {
                                    i++;
                                  });
                                  a = pointTaken;
                                }
                                    : null,
                                child: const Text('Phase 1')),
                          ),
                          Positioned(
                            right: 35,
                            bottom: 330,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow, // Background color
                                ),
                                onPressed: active % 11 == 1
                                    ? () async {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    setState(() {
                                      active++;
                                    });
                                  });
                                  pointTaken =
                                  await Navigator.of(context).push<int>(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PhaseTwo(questions: mainQuestions);
                                      },
                                    ),
                                  );
                                  sumPoints.add(pointTaken);
                                  setState(() {
                                    i++;
                                  });
                                  b = pointTaken;
                                }
                                    : null,
                                child: const Text('Phase 2')),
                          ),
                          Positioned(
                            left: 35,
                            bottom: 280,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple, // Background color
                                ),
                                onPressed: active % 11 == 2
                                    ? () async {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    setState(() {
                                      active++;
                                    });
                                  });
                                  pointTaken =
                                  await Navigator.of(context).push<int>(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PhaseThree(questions: mainQuestions);
                                      },
                                    ),
                                  );
                                  sumPoints.add(pointTaken);
                                  setState(() {
                                    i++;
                                  });
                                  c = pointTaken;
                                }
                                    : null,
                                child: const Text('Phase 3')),
                          ),
                          Positioned(
                            right: 35,
                            bottom: 280,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange, // Background color
                                ),
                                onPressed: active % 11 == 3
                                    ? () async {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    setState(() {
                                      active++;
                                    });
                                  });
                                  pointTaken =
                                  await Navigator.of(context).push<int>(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PhaseFour(questions: mainQuestions);
                                      },
                                    ),
                                  );
                                  sumPoints.add(pointTaken);
                                  setState(() {
                                    i++;
                                  });
                                  d = pointTaken;
                                }
                                    : null,
                                child: const Text('Phase 4')),
                          ),
                          Positioned(
                            left: 35,
                            bottom: 230,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red, // Background color
                                ),
                                onPressed: active % 11 == 4
                                    ? () async {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    setState(() {
                                      active++;
                                    });
                                  });
                                  pointTaken =
                                  await Navigator.of(context).push<int>(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PhaseFive(questions: mainQuestions);
                                      },
                                    ),
                                  );
                                  sumPoints.add(pointTaken);
                                  setState(() {
                                    i++;
                                  });
                                  e = pointTaken;
                                }
                                    : null,
                                child: const Text('Phase 5')),
                          ),
                          Positioned(
                            right: 35,
                            bottom: 230,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.brown, // Background color
                                ),
                                onPressed: active % 11 == 5
                                    ? () async {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    setState(() {
                                      active++;
                                    });
                                  });
                                  pointTaken =
                                  await Navigator.of(context).push<int>(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PhaseSix(questions: mainQuestions);
                                      },
                                    ),
                                  );
                                  sumPoints.add(pointTaken);
                                  setState(() {
                                    i++;
                                  });
                                  f = pointTaken;
                                }
                                    : null,
                                child: const Text('Phase 6')),
                          ),
                          Positioned(
                            left: 35,
                            bottom: 180,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.tealAccent, // Background color
                                ),
                                onPressed: active % 11 == 6
                                    ? () async {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    setState(() {
                                      active++;
                                    });
                                  });
                                  pointTaken =
                                  await Navigator.of(context).push<int>(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PhaseSeven(questions: mainQuestions);
                                      },
                                    ),
                                  );
                                  sumPoints.add(pointTaken);
                                  setState(() {
                                    i++;
                                  });
                                  g = pointTaken;
                                }
                                    : null,
                                child: const Text('Phase 7')),
                          ),
                          Positioned(
                            right: 35,
                            bottom: 180,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black45, // Background color
                                ),
                                onPressed: active % 11 == 7
                                    ? () async {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    setState(() {
                                      active++;
                                    });
                                  });
                                  pointTaken =
                                  await Navigator.of(context).push<int>(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PhaseEight(questions: mainQuestions);
                                      },
                                    ),
                                  );
                                  sumPoints.add(pointTaken);
                                  setState(() {
                                    i++;
                                  });
                                  h = pointTaken;
                                }
                                    : null,
                                child: const Text('Phase 8')),
                          ),
                          Positioned(
                            left: 35,
                            bottom: 130,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pinkAccent, // Background color
                                ),
                                onPressed: active % 11 == 8
                                    ? () async {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    setState(() {
                                      active++;
                                    });
                                  });
                                  pointTaken =
                                  await Navigator.of(context).push<int>(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PhaseNine(questions: mainQuestions);
                                      },
                                    ),
                                  );
                                  sumPoints.add(pointTaken);
                                  setState(() {
                                    i++;
                                  });
                                  j = pointTaken;
                                }
                                    : null,
                                child: const Text('Phase 9')),
                          ),
                          Positioned(
                            right: 30,
                            bottom: 130,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyanAccent, // Background color
                                ),
                                onPressed: active % 11 == 9
                                    ? () async {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    setState(() {
                                      active++;
                                    });
                                  });
                                  pointTaken =
                                  await Navigator.of(context).push<int>(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PhaseTen(questions: mainQuestions);
                                      },
                                    ),
                                  );
                                  sumPoints.add(pointTaken);
                                  setState(() {
                                    i++;
                                  });
                                  k = pointTaken;
                                }
                                    : null,
                                child: const Text('Phase 10')),
                          ),
                          Positioned(
                            right: 90,
                            bottom: 70,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black, // Background color
                                ),
                                onPressed: () {
                                  RestartWidget.restartApp(context);
                                } ,
                                child: const Text('Restart')),
                          ),
                        ],
                      )
                    ),
                    //Text('Heyfasdfasdfa'),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Container(
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Builder(
                          builder: (context) => TextButton(
                              onPressed: (){
                                Scaffold.of(context).openDrawer();
                              },
                              style: TextButton.styleFrom(
                              foregroundColor: Colors.white, // Text Color
                            ),
                              child: const Text('Score Table'),
                          ),
                        ),
                        const Icon(Icons.question_mark,
                        color: Colors.white),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white, // Text Color
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const HowToPlay();
                            }));
                          },
                          child: const Text('How To Play'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      boxShadow: const [BoxShadow(blurRadius: 40.0)],
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 100.0)),
                    ),
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
