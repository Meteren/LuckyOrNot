import 'dart:async';
import 'package:Lucky_or_Not/app_pages/question_list_page.dart';
import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'package:Lucky_or_Not/utils/db_utils.dart';
import 'package:Lucky_or_Not/models/user_question.dart';

import 'main_page.dart';

DbUtils utils = DbUtils();

class QuestionStoragePage extends StatefulWidget {
  const QuestionStoragePage({Key? key}) : super(key: key);

  @override
  _QuestionStoragePageState createState() => _QuestionStoragePageState();
}

class _QuestionStoragePageState extends State<QuestionStoragePage> {
  TextEditingController questionIdController = TextEditingController();
  TextEditingController questionTextController = TextEditingController();
  TextEditingController questionAnswerController = TextEditingController();

  String? answer;

  Timer? timer;

  bool check = false;

  final _formKey = GlobalKey<FormState>();

  late Future<Database> database;

  List<UserQuestion> userQuestionsList = [];

  void initState() {
    // TODO: implement initState
    super.initState();

    getData();

    timer = Timer.periodic(Duration(
      seconds: 1 ,
    ),
            (_){
          setState(() {
            check = !check;
          });
        });
  }


  _onPressedAdd() async {
    final question = UserQuestion(
      id: int.parse(questionIdController.text),
      question: questionTextController.text,
      answer: questionAnswerController.text,
    );
    utils.insertQuestion(question);
    userQuestionsList = await utils.questions();
    getData();
  }

  _deleteQuestionTable() {
    utils.deleteTable();
    userQuestionsList = [];
    getData();
  }

  void getData() async {
    await utils.questions().then((result) => {
      setState(() {
        userQuestionsList = result;
      })
    });
    print(userQuestionsList);
  }


  void didChangeAppLifecycleState(AppLifecycleState state) {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      backgroundColor: Colors.grey[300],
        appBar: AppBar(
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          title: Text("Question Storage"),
        backgroundColor: Colors.grey,),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                    ),
                  height: 240,
                  width: 400,
                  child: Column(
                    children: [
                      MyTextFormField(
                        questionTextController: questionTextController,
                        labelText: 'Enter Question',
                      ),
                      MyTextFormField(
                          questionTextController: questionIdController,
                          labelText: 'Enter ID Question' ,
                      ),
                      DropdownButtonFormField(
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
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                  ),
                  height: 130,
                  width: 400,
                child:Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                          onPressed: _onPressedAdd, child: Text("Insert Question")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                          onPressed: _deleteQuestionTable,
                          child: const Text("Delete Question Table")),
                    ),
                  ]
                  ,)
                  ,),
                SizedBox(
                  height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Double tap to go to',
                      style: TextStyle(fontStyle: FontStyle.italic),),
                      AnimatedPadding(
                          padding: check ? EdgeInsets.only(right: 50) : EdgeInsets.only(left:0),
                          child: Icon(Icons.arrow_forward),
                          duration: Duration(seconds: 1)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onDoubleTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=>QuestionList()));
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(color: Colors.grey,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10), ),
                            child: Center(child: Text('Questions List',
                            style: TextStyle(color: Colors.white),))
                          ),
                        )
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.questionTextController,
    required this.labelText
  });

  final String labelText;

  final TextEditingController questionTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: questionTextController,
        decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: labelText
        ),
      ),
    );
  }
}

