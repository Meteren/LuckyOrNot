import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetHighestScores extends StatelessWidget {
  final String docID;

  GetHighestScores({Key? key, required this.docID}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance.collection('users');
    return FutureBuilder(
        future: user.doc(docID).get(),
        builder: (context,snapshot){
          if (snapshot.hasData) {
            final data = snapshot.data!.data();
            return Text('${data!['email']}: ${data['highscore']} point(s)');
          }
          return Text('Loading...');
        });
  }
}
