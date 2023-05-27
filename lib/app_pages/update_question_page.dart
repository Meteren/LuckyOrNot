import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/user_question.dart';
import '../utils/db_utils.dart';

DbUtils utils = DbUtils();

class UpdateQuestionPage extends StatefulWidget {
  UpdateQuestionPage({Key? key,
    required this.questionId}) : super(key: key);

  final int questionId;

  @override
  State<UpdateQuestionPage> createState() => _UpdateQuestionPageState();
}

class _UpdateQuestionPageState extends State<UpdateQuestionPage> {

  String? answer;

  TextEditingController questionTextController = TextEditingController();

  TextEditingController questionAnswerController = TextEditingController();


  _updateQuestion() async {
    final question = UserQuestion(
      id: widget.questionId,
      question: questionTextController.text,
      answer: answer!,
    );
    utils.updateQuestion(question);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Center(child: Text("Question Update")),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey,),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height:150,
                  width: 150,
                  child: Lottie.asset('assets/lottiefiles/89749-rockert-new.zip')),
              SizedBox(height: 50,),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                height: 200,
                width: 400,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: questionTextController,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter Question'
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  DropdownButtonFormField(
                        items:[
                          DropdownMenuItem(
                            child: Text('True',
                              style: TextStyle(color: Colors.green),),
                            value: 'True',),
                          DropdownMenuItem(
                            child: Text('False',
                              style: TextStyle(color: Colors.red),),
                            value: 'False',)
                        ],
                        value: answer,
                        onChanged: (value){
                          setState(() {
                            answer = value;
                          });
                        },
                        validator: (value){
                          if(value == null){
                            return 'Please enter your answer';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed:(){
                if (questionTextController.text == '' || questionAnswerController == '' ) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Fill the blanks!!'),
                  duration: Duration(seconds: 2),));
                }
                else {
                  _updateQuestion();
                  Navigator.pop(context);
                }
              }, child: Text('Update')),
            ],
          ),
        ),
      ),
    );
  }
}



