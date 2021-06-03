import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImg) imagePickFn;
  UserImagePicker(this.imagePickFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async{
    final picker = ImagePicker();
    final pickedImageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150
    );
    setState(() {
      _pickedImage = File(pickedImageFile.path);      
    });
    widget.imagePickFn(File(pickedImageFile.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey,
        backgroundImage: _pickedImage!=null? FileImage(_pickedImage):null,
      ),
      FlatButton.icon(
        onPressed: _pickImage, 
        icon: Icon(Icons.image), 
        label: Text('Add image'),
        textColor: Theme.of(context).primaryColor,
      ),
    ],);
  }
}