import 'package:flutter/material.dart';

import './result.dart';
import './quiz_widget.dart';

// void main() {
//  runApp(MyApp()); //runs app with MyAPP as core widget. Flutter auto calls build funct
// }

void main() => runApp(MyApp());

//Stateless widgets dont change their structure or display values. They can be updated by external data on rebuilding the app
//Stateful widgets can update based on external data as well as input state and re renders for a change in internal state

class MyApp extends StatefulWidget { //To create a stateful widget we have to have an internal state class linked with it
  @override
  _MyAppState createState(){
      return _MyAppState();
  } 
}

// the _ makes a variable, class or function private. So below class cannot be imported into other files
class _MyAppState extends State<MyApp> { //This is the State class which acts as the internal state of the stateful widget
  int _questionIndex = 0; //This var cant be modified outside this state class
  var _totalScore = 0;

  final _questions = const [
      {'questionText':'What\'s your favourite colour', 'answers':[
        {'text':'Red','Score':9},
        {'text':'Green','Score':7},
        {'text':'Blue','Score':5},
        {'text':'Yellow','Score':3}
        ]},

      {'questionText':'What\'s your favourite animal', 'answers':[
        {'text':'Dog','Score':1},
        {'text':'Cat','Score':3},
        {'text':'Lion','Score':5},
        {'text':'Bird','Score':4}
        ]},
      {'questionText':'What\'s your favourite city', 'answers':[
        {'text':'Madrid','Score':1},
        {'text':'Bangalore','Score':1},
        {'text':'Paris','Score':1},
        {'text':'Los Angeles','Score':1}
        ]}
  ];

  void _resetQuiz(){
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score){
    _totalScore += score;
    setState(() { //This function tells flutter to render only when it is called i.e. on change of an internal state property
    //setState calls build for this particular widget again with the updated stuff
      _questionIndex = _questionIndex +1;
    });
    
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(home: Scaffold(
      appBar: AppBar(title: Text('My first app'),),
      body: (_questionIndex < _questions.length)? Quiz(
        questionList: _questions,
        callback: _answerQuestion,
        questionIndex: _questionIndex,
        ) : Result(_totalScore,_resetQuiz) , //Now this takes in a list of widgets to be rendered in a column
      )
    ); 
  }
}