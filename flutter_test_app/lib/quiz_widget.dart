import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String,Object>> questionList;
  final questionIndex;
  final Function callback;

  Quiz({this.questionList, this.questionIndex, this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
        Question(questionList[questionIndex]['questionText']),
        ...(questionList[questionIndex]['answers'] as List<Map<String,Object>>).map(
          (answer){
            return Answer(() => this.callback(answer['Score']), answer['text']);
          }
        ).toList(),
        
      ],);
  }
}