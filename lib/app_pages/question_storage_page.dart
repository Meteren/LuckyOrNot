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

  String? answer;
  Timer? timer;

  bool check = false;

  final _formKey = GlobalKey<FormState>();

  late Future<Database> database;

  List<UserQuestion> userQuestionsList = [];

  String? userQuestion;

  String? questionId;

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
    try {
      final question = UserQuestion(
        id: int.parse(questionId!.trim()),
        question: userQuestion!,
        answer: answer!,
      );
      utils.insertQuestion(question);
      userQuestionsList = await utils.questions();
      getData();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Question added.'),
      duration: Duration(seconds: 2)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong.\n${e.toString()}'),
          duration: Duration(seconds: 2)));
    }
  }

  _deleteQuestionTable() {
    try {
      utils.deleteTable();
      userQuestionsList = [];
      getData();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Question table deleted.'),
          duration: Duration(seconds: 2)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong.\n${e.toString()}'),
          duration: Duration(seconds: 2)));
    }
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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                    height: 260,
                    width: 400,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Enter Question'
                            ),
                            validator: (val){
                              if(val == null || val.trim().isNotEmpty != true){
                                return 'Enter Question';
                              }
                              return null;
                            },
                            onChanged: (val){
                              setState(() {
                                userQuestion = val;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Enter question id',
                            ),
                            validator: (value){
                              if(value == null || value.trim().isNotEmpty != true){
                                return 'You need to enter your question id.';
                              }
                              if(int.tryParse(value.trim()) == null){
                                return 'Id must be a number.';
                              }
                              return null;
                            },
                            onChanged: (val){
                              setState(() {
                                questionId = val;
                              });
                            },
                          ),
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
                            onPressed: (){
                              final formState = _formKey.currentState;
                              if(formState == true) return null;
                              if(formState?.validate() == true){
                                formState?.save();
                                print(userQuestionsList);
                              }
                              _onPressedAdd();
                            }, child: Text("Insert Question")),
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
        ),
      );
  }
}



