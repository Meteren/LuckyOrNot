import 'package:Lucky_or_Not/models/questions.dart';
import 'package:flutter/material.dart';
import '../utils/db_utils.dart';

DbUtils utils = DbUtils();

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({Key? key}) : super(key: key);

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  TextEditingController questionIdController = TextEditingController();
  bool active = false;
  bool isSaving = false;
  final Map<String,dynamic> added_question = {};
  final _formKey = GlobalKey<FormState>();


  Future assigner(TextEditingController contr) async{
    final map = await utils.selectQuestion(int.parse(contr.text.trim()));
    added_question['question'] = map[0]['question'];
  }

  Future<void> save() async {
    try {
      setState(() {
        isSaving = true;
      });
      final question = Question.fromMap(added_question);
      await addQuestion(question);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Question saved')));
      Navigator.of(context).pop();
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong.Try to check id if its correct or not or fill the blanks.')));
    }finally{
      setState(() {
        isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        actions: [Icon(Icons.question_mark),SizedBox(width: 10,),],
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Add Your Question'),
        leading: Icon(Icons.question_mark),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  SizedBox(
                    width: 200,
                      height: 200,
                      child: Image.asset('assets/images/question_mark_trio.png')),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your question id',
                    ),
                    validator: (value){
                      if(value == null || value.trim().isNotEmpty != true){
                        return 'You need to enter your question id.';
                      }
                      if(int.tryParse(value) == null){
                        return 'Id must be a number.';
                      }
                      return null;
                    },
                   controller: questionIdController,
                    onChanged: (Val){
                      setState(() {
                        active = true;
                      });
                    },
                  ),
                  SizedBox(height: 20,),
                 DropdownButtonFormField(
                     items:[
                       DropdownMenuItem(
                         child: Text('True',
                         style: TextStyle(color: Colors.green),),
                         value: true,),
                       DropdownMenuItem(
                         child: Text('False',
                         style: TextStyle(color: Colors.red),),
                         value: false,)
                     ],
                    value: added_question['answer'],
                    onChanged: (value){
                       setState(() {
                         added_question['answer'] = value;
                       });
                    },
                   validator: (value){
                       if(value == null){
                         return 'Please enter your answer';
                       }
                       return null;
                   },
                 ),
                  SizedBox(height: 10,),
                  isSaving ? CircularProgressIndicator()
                      : ElevatedButton(onPressed: active ? () async{
                    final formState = _formKey.currentState;
                    if(formState == true) return null;
                    if(formState?.validate() == true){
                      formState?.save();
                      //print(added_question);
                    }
                    await assigner(questionIdController);
                    save();
                    }: null ,
                   child: Text('Save Your Question'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:Colors.black ),)
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}


