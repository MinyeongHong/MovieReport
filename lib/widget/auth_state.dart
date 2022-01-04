import 'package:MovieReviewApp/page/auth_login.dart';
import 'package:MovieReviewApp/page/auth_register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthenticationState extends StatefulWidget {
  const AuthenticationState({Key? key}) : super(key: key);

  @override
  _AuthenticationStateState createState() => _AuthenticationStateState();
}

class _AuthenticationStateState extends State<AuthenticationState> {
  bool showSignIn = false;
  void toggleScreen(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return register(toggleScreen: toggleScreen);
    }else{
      return Login(toggleScreen: toggleScreen);
    }
  }
}

