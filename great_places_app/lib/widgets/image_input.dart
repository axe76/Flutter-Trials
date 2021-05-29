import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function _onSelectImage;

  ImageInput(this._onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async{
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );//ImageSource.gallery also available for gallery image select
    if(imageFile == null){
      return;
    }
    final imageFilePath = File(imageFile.path);
    setState(() {
      _storedImage = imageFilePath;
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(imageFilePath.path);//this gets only file name not full path
    final savedImage = await imageFilePath.copy('${appDir.path}/$filename');
    widget._onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(width:1,color: Colors.grey)
          ),
          child: _storedImage!=null? Image.file(
            _storedImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ):Text('No image taken!',textAlign: TextAlign.center,),
          alignment: Alignment.center,
        ),
        SizedBox(height: 10,),
        Expanded(
          child: FlatButton.icon(
            icon:Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture, 
          )
        )
      ],
    );
  }
}