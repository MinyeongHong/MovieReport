import 'package:MovieReviewApp/page/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'auth_state.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  get toggleScreen => null;


  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User>(context);
    if(firebaseUser != null && firebaseUser.emailVerified){
      return Main();
    }
    else return AuthenticationState();
  }
}
