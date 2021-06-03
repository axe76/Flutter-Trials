import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLodaing = false;

  void _submitAuthForm(String email,String password, String username, File image, bool isLogin, BuildContext ctx) async {
    UserCredential authResult;
    try{
      setState(() {
        _isLodaing = true;
      });
      if(isLogin){
      authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      }else{
        authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        final ref = FirebaseStorage.instance.ref().child('user_images').child(authResult.user.uid+'.jpg');
        //ref points at root firebase storage bucket and child creates a folder in that bucket
        await ref.putFile(image);
        final user_img_url = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).set({//storing extra data like username in collection called users which will be created on the fly
          'username':username,
          'email':email,
          'image_url':user_img_url,
        });
      }
    }on PlatformException catch(error){
      var message = 'An error occured, pleases check your credentials';
      if(error!=null){
        message = error.message;
      }
      setState(() {
        _isLodaing = false;
      });
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        )
      );
    }catch(error){
      print(error);
      setState(() {
        _isLodaing = false;
      });
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).errorColor,
        )
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm,_isLodaing),
    );
  }
}