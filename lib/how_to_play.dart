import 'package:flutter/material.dart';

class HowToPlay extends StatefulWidget {
  const HowToPlay({
    super.key,
  });

  @override
  State<HowToPlay> createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Instructions To Play'),
        ),
        body: SizedBox(
          width: 410,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 250,
            child: const Text('The game has 10 different phases, each of them containing'
                ' variety of points. By hitting -Start Game- button, you will be directed to one of'
                ' these phases. The points you will see in these phases depend on a luck system. To engage'
                ' this luck system press the button highlighted as -Decide- which takes'
                ' place in every phase to see where your fate will take you.'
                ' Thus you will be randomly routed to one of the greyed out buttons'
                ' that containing a question and corresponding to a point which'
                ' is again determined by the greyed out button. You need to answer this question'
                ' right to gain the point that button equals. And that point will be decided'
                ' by your fate as stated before. Every phase has different type of points.'
                ' By completing one phase and passing over next one, the probability of a'
                ' high point route chance will decrease at the same time. As you can understand,'
                ' having knowledge is not enough to hit a high score without luck is being beside you.'
                ' After completing a phase, use signifed buttons to go back to main page.'
                ' In this page, you will see a score table statement bottom'
                ' of the screen. Use this button to see your earned points in every phase and (after completing'
                ' all phases) calculate your score. ',
              textScaleFactor: 1.3,
            ),
          ),
        )
    );
  }
}