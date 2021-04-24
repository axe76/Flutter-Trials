import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final nameController = TextEditingController();
  final costController = TextEditingController();
  final Function addTx;

  NewTransaction(this.addTx);


  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 4,
            child: Container(
            padding: EdgeInsets.all(10),
            child:Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(decoration: InputDecoration(labelText: "Name"),controller: nameController,),
              TextField(decoration: InputDecoration(labelText: "Amount"),controller: costController,),
              FlatButton(onPressed: (){
                addTx(nameController.text,double.parse(costController.text));
              }, child: Text("Add transaction",style: TextStyle(color: Colors.purple),))

            ],),
          ),);
  }
}