import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier{
  String _token;
  DateTime expiryDate;
  String _userId;

  Future<void> signUp(String email, String password) async{
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBkt_j6W8zOrSJdnwkKIkjq7l7Vj3eTEmg');
    final response = await http.post(url,body:json.encode({
      'email':email,
      'password':password,
      'returnSecureToken':true,
    }));
    print(json.decode(response.body));
  }

  Future<void> logIn(String email, String password) async{
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBkt_j6W8zOrSJdnwkKIkjq7l7Vj3eTEmg');
    final response = await http.post(url,body:json.encode({
      'email':email,
      'password':password,
      'returnSecureToken':true,
    }));
    print(json.decode(response.body));
  }
}