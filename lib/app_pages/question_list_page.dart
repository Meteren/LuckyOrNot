import 'package:Lucky_or_Not/app_pages/add_question_page.dart';
import 'package:Lucky_or_Not/app_pages/update_question_page.dart';
import 'package:Lucky_or_Not/models/user_question.dart';
import "package:flutter/material.dart";
import 'package:flutter_slidable/flutter_slidable.dart';
import '../utils/db_utils.dart';
import '../utils/file_utils.dart';

DbUtils utils = DbUtils();

class QuestionList extends StatefulWidget {
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  List<UserQuestion> userQuestionList = [];

  String fileContents = '';

  void getData() async {
    await utils.questions().then((result) => {
      setState(() {
        userQuestionList = result;
      })
    });
    print(userQuestionList);
  }

  void showAlert(String alertTitle, String alertContent) {
    AlertDialog alertDialog;
    alertDialog =
        AlertDialog(title: Text(alertTitle), content: Text(alertContent));
    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text(userQuestionList.length.toString() + " Question(s) listed")),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: userQuestionList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                      children:  [
                        SlidableAction(
                          onPressed: (context) async{
                            try {
                              await utils.deleteQuestion(userQuestionList[index].id).then((value) => {
                                showAlert("Success!!",
                                "Question ${userQuestionList[index].id} deleted")
                              });
                              getData();
                            } catch (e) {
                              showAlert('Oops!', 'Something went wrong\n${e.toString()}');
                            }
                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                        SlidableAction(
                          onPressed: (context){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>UpdateQuestionPage(
                                      questionId:userQuestionList[index].id )))
                                  .then((value) {setState((){getData();});});
                          },
                          backgroundColor: Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.add,
                          label: 'Update',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) async{
                             try {
                               await FileUtils.saveToFile('${userQuestionList[index].question}: ${userQuestionList[index].answer}');
                               showAlert('Success!!', 'Saved as favorite');
                             } catch (e) {
                               showAlert('Oops!', 'Something went wrong');
                             }
                          },
                          backgroundColor: Colors.pinkAccent,
                          foregroundColor: Colors.white,
                          icon: Icons.favorite,
                          label: 'Favorite',
                        ),
                        SlidableAction(
                          onPressed: (context) async{
                           await FileUtils.readFromFile(context).then((contents) {
                              setState(() {
                                fileContents = contents;
                              });
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(fileContents),
                            duration: Duration(seconds: 2),));
                          },
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.white,
                          icon: Icons.remove_red_eye,
                          label: 'Show',
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddQuestionPage())),
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xff6ae792),
                        child: Text('${userQuestionList[index].id}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      title: Text(userQuestionList[index].question),
                      subtitle: Text('Answer:${userQuestionList[index].answer}'),
                        tileColor: Colors.grey[200],
                        shape: UnderlineInputBorder(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}