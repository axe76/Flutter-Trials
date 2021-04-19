import 'package:flutter/material.dart';

// void main() {
//  runApp(MyApp()); //runs app with MyAPP as core widget. Flutter auto calls build funct
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  void answerQuestion(){
    print('Answer chosen');
  }

  @override
  Widget build(BuildContext context) {
    var questions = ['What\'s your favourite colour?','What\'s your favourite animal?'];
    return MaterialApp(home: Scaffold(
      appBar: AppBar(title: Text('My first app'),),
      body: Column(children: <Widget>[
        Text('The question!'),
        RaisedButton(child: Text('Answer 1'),onPressed: answerQuestion,),
        RaisedButton(child: Text('Answer 2'),onPressed: () => print('Anser 2 chosen')),
        RaisedButton(child: Text('Answer 3'),onPressed: (){
          //...
          print('Answer 3 chosen');
        },),
      ],), //Now this takes in a list of widgets to be rendered in a column
      )
    ); 
  }
}