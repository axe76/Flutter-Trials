import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final Function resetCallback;

  Result(this.score, this.resetCallback);

  String get resultPhrase{
    return "Your Score is: $score.\n Max Score: 15 and Min score: 5.\n The higher the score, the worse you are.";
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        Text(
          resultPhrase,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,),
        FlatButton(
          onPressed: this.resetCallback, 
          child: Text("Reset Quiz",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          textColor: Colors.blue,)
      ],
    ));
      
  }
}