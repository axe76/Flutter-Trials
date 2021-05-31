import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats/4rxDesicuZfIPddQA4Pc/messages').snapshots(),//snapshot sets up a listener to the firestore database. so when data changes this is notified auto,
        builder: (ctx,streamSnapshot) {
          
          if(streamSnapshot.connectionState == ConnectionState.waiting){
            return Center(child:CircularProgressIndicator());
          }
          final documents = streamSnapshot.data.docs;
          return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (ctx,i)=>Container(
                      padding: EdgeInsets.all(8),
                      child: Text(documents[i]['text']),
                    ),
                  );
        },
      ) ,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          FirebaseFirestore.instance
          .collection('chats/4rxDesicuZfIPddQA4Pc/messages')
          .add({
              'text':'Clicked button',
          });
        },
      ),
    );
  }
}

