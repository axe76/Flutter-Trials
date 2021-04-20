import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

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

  void _answerQuestion(){
    setState(() { //This function tells flutter to render only when it is called i.e. on change of an internal state property
    //setState calls build for this particular widget again with the updated stuff
      _questionIndex = _questionIndex +1;
    });
    
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      {'questionText':'What\'s your favourite colour', 'answers':['Red','Green','Blue','Yellow']},
      {'questionText':'What\'s your favourite animal', 'answers':['Dog','Cat','Lion','Bird']},
      {'questionText':'What\'s your favourite city', 'answers':['Madrid','Bangalore','Paris','Los Angeles']}
    ];

    return MaterialApp(home: Scaffold(
      appBar: AppBar(title: Text('My first app'),),
      body: Column(children: <Widget>[
        Question(questions[_questionIndex]['questionText']),
        ...(questions[_questionIndex]['answers'] as List<String>).map(
          (answer){
            return Answer(_answerQuestion, answer);
          }
        ).toList(),
        
      ],), //Now this takes in a list of widgets to be rendered in a column
      )
    ); 
  }
}