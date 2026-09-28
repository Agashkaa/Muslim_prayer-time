import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentIDs;
  const GetUserName({super.key, required this.documentIDs});
  @override
  Widget build(BuildContext context) {

    //get the collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');


    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentIDs).get(),
      builder: ((context,snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        Map<String,dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
        final firstname = (data['first name'] ?? 'Näbelli') as String;
        final page = data['page'] ?? 'null';
        return Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text('$firstname',style: TextStyle(color: Colors.black),),
            Text('$page' ,style: TextStyle(color: Colors.black),),

          ],
        );
      }
      return Text("loading...");
        }),
    );
  }
}
