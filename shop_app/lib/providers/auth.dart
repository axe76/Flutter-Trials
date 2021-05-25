import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exceptions.dart';

class Auth with ChangeNotifier{
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth{
    return token!=null;
  }

  String get token{
    if(_expiryDate != null && _expiryDate.isAfter(DateTime.now()) && _token!=null){
      return _token;
    }
    return null;
  }

  String get userId{
    return _userId;
  }

  Future<void> signUp(String email, String password) async{
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBkt_j6W8zOrSJdnwkKIkjq7l7Vj3eTEmg');
    try{
      final response = await http.post(url,body:json.encode({
      'email':email,
      'password':password,
      'returnSecureToken':true,
      }));
      final responseData = json.decode(response.body);
      if(responseData['error'] != null){
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn'])
        )
      );
      notifyListeners();
    }catch(error){
      throw error;
    }
    
    //print(json.decode(response.body));
  }

  Future<void> logIn(String email, String password) async{
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBkt_j6W8zOrSJdnwkKIkjq7l7Vj3eTEmg');
    try{
      final response = await http.post(url,body:json.encode({
          'email':email,
          'password':password,
          'returnSecureToken':true,
          }
        )
      );
      final responseData = json.decode(response.body);
      if(responseData['error'] != null){
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn'])
        )
      );
      notifyListeners();
    }catch(error){
      throw error;
    }
    
    //print(json.decode(response.body));
  }
}