import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function callback;
  final String text;

  Answer(this.callback,this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        textColor: Colors.white,
        color: Colors.blue,
        child: Text(text),
        onPressed: callback),
    );
  }
}