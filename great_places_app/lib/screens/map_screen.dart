import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialPos;
  final bool isSelecting;

  MapScreen({this.initialPos = const PlaceLocation(latitude:37.3445,longitude:-122.0016),this.isSelecting=false});//default vals

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectPlace(LatLng position){
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: [
          if(widget.isSelecting) IconButton(
            icon: Icon(Icons.check), 
            onPressed: _pickedLocation == null?null: (){
              Navigator.of(context).pop(_pickedLocation);//return _pickedlocation to previous screen in stack
            }
          )
        ],  
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialPos.latitude,widget.initialPos.longitude),
          zoom: 16
        ),
        onTap: widget.isSelecting? _selectPlace :null,
        markers:(_pickedLocation==null && widget.isSelecting)? null : {
          Marker(markerId: MarkerId('m1'),position: _pickedLocation ?? LatLng(
            widget.initialPos.latitude,widget.initialPos.longitude
            ),)//if pickedloc is null then put marker on initial pos. This is for viewing from place detail screen
        },
      ),
    );
  }
}