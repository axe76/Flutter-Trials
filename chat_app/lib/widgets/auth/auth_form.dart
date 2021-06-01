import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool _isLodaing;
  final void Function(String email, String password, String username, bool isLogin, BuildContext ctx) submitFunction;

  AuthForm(this.submitFunction,this._isLodaing);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySybmit(){
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();//removes focus from form and closes keyboard

    if(isValid){
      _formKey.currentState.save();//triggers on saved for each form
      // print(_userEmail);
      // print(_userName);
      // print(_userPassword);
      widget.submitFunction(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key:ValueKey('email'),
                    validator: (value){
                      if(value.isEmpty || !value.contains('@')){
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email Address'),
                    onSaved: (value){
                      _userEmail = value;
                    },
                  ),
                  if(!_isLogin)
                  TextFormField(
                    key:ValueKey('username'),
                    validator: (value){
                      if(value.isEmpty || value.length<4){
                        return 'Please enter atleast 4 chars';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Username'),
                    onSaved: (value){
                      _userName = value;
                    },
                  ),
                  TextFormField(
                    key:ValueKey('password'),
                    validator: (value){
                      if(value.isEmpty || value.length<7){
                        return 'Password should be atleast 7 chars long';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'password'),
                    obscureText: true,
                    onSaved: (value){
                      _userPassword = value;
                    },
                  ),
                  SizedBox(height:12),
                  if(widget._isLodaing) CircularProgressIndicator(),
                  if(!widget._isLodaing)
                    RaisedButton(
                      child: Text(_isLogin?'Login':'Signup'),
                      onPressed: _trySybmit,
                    ),
                  if(!widget._isLodaing)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin?'Create new account':'I already have an account'),
                      onPressed: (){
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
              ],),
            ),
          ),
        ),
      );
  }
}