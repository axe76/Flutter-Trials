import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import 'map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail-screen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace = Provider.of<GreatPlaces>(context,listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(children: [
        Container(
          height:250,
          width:double.infinity,
          child:Image.file(selectedPlace.image, width: double.infinity, fit: BoxFit.cover,),
        ),
        SizedBox(height:10),
        Text(
          selectedPlace.location.address,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey,fontSize: 20),),
        SizedBox(height:20),
        FlatButton(
          child: Text('View on Map'),
          textColor: Theme.of(context).primaryColor,
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx)=>MapScreen(initialPos: selectedPlace.location,isSelecting: false,))
            );
          },
        )
      ],),
    );
  }
}