import 'package:Lucky_or_Not/app_pages/main_page.dart';
import 'package:Lucky_or_Not/read_data/get_user_highest_scores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ScoreTablePage extends StatefulWidget {
  const ScoreTablePage({Key? key}) : super(key: key);

  @override
  State<ScoreTablePage> createState() => _ScoreTablePageState();
}

class _ScoreTablePageState extends State<ScoreTablePage> {
  List<String> docIds = [];

  Future getDocIDs() async{
    await FirebaseFirestore.instance.collection('users')
        .orderBy('highscore',descending: true)
        .get()
        .then((snapshot)
    => snapshot.docs.forEach((element) {
      docIds.add(element.reference.id);
    }));
  }
   findMyPlace() async{
    final uid = await FirebaseAuth.instance.currentUser!.uid;
    for(int i = 0; i < docIds.length; i++){
      if(docIds[i] == uid){
        return showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Your Place:'),
            content: Text('You are at the ${i+1}. place.'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(title: Text('Score Table'),
      backgroundColor: Colors.black,),
      body: Center(
        child: Column(
          children: [
            Expanded(child: FutureBuilder(
              future: getDocIDs(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: docIds.length ,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xff6ae792),
                            child: Text('${index+1}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          title: GetHighestScores(docID: docIds[index]),
                          tileColor: Colors.grey[200],
                          shape: BeveledRectangleBorder( //<-- SEE HERE
                          side: BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20),
                          )
                      ),
                    );
                  }
                  );
              }
            )
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: findMyPlace,
                child: Text('Find My Place')),
          ],
        ),
      ),
    );
  }
}
