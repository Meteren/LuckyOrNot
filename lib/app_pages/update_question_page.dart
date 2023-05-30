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

  final _formKey = GlobalKey<FormState>();

  String? userQuestion;

  String? answer;


  _updateQuestion() async {
    try {
      final question = UserQuestion(
        id: widget.questionId,
        question: userQuestion!,
        answer: answer!,
      );
      utils.updateQuestion(question);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Question updated.'),
        duration: Duration(seconds: 2),));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong.')));
    }
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
        child: Form(
          key: _formKey,
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
                              if (value != null) {
                                answer = value;
                              }
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
               SizedBox(height: 15,),
               GestureDetector(
                 onLongPressUp: (){
                   final formState = _formKey.currentState;
                   if(formState == true) return null;
                   if(formState?.validate() == true){
                     formState?.save();
                     //print(added_question);
                   }
                   _updateQuestion();

                     },
                 child: Container(
                   width: 70,
                   height: 40,
                   decoration: BoxDecoration(color: Colors.grey),
                   child: Center(child: Text('Update',style: TextStyle(color: Colors.white),)),
                 ),
               ),
                SizedBox(height: 10,),
                Text('Long press to update'),
              ],
            ),
          ),
        ),
      ),

    );
  }
}



