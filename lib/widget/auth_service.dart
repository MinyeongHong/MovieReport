import 'dart:io';
import 'package:MovieReviewApp/page/auth_login.dart';
import 'package:MovieReviewApp/page/auth_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthServices with ChangeNotifier {

  bool _isLoading = false;
  late String _errorMessage;
  bool get isLoading =>_isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future register(String email,String password) async {
    setLoading(true);
    try{
      UserCredential authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      if(user!=null) {
        await user.sendEmailVerification();
        setLoading(false);
        logout();
        return user;
      }
    } on SocketException{
      setLoading(false);
      setMessage("인터넷 연결 없음");
    } on FirebaseAuthException catch(e){
      return e.message;
    }
    notifyListeners();
  }

  Future login(String email,String password) async {
    setLoading(true);
    try{
      UserCredential authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException{
      setLoading(false);
      setMessage("인터넷 연결 없음");
    } on FirebaseAuthException catch(e){
      setLoading(false);
      return e.message;
    }
    notifyListeners();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.setLanguageCode("ko");
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future logout() async{
    await _firebaseAuth.signOut();
  }

  Future removeAccount() async{
    try {
      await _firebaseAuth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print('오류가 발생하였습니다. 다시 로그인 후 시도해주세요');
      }
    }
  }



  void setLoading(val){
    _isLoading = val;
    notifyListeners();
  }
  void setMessage(message){
    _errorMessage = message;
    notifyListeners();
  }

  Stream<User?> get user => _firebaseAuth.authStateChanges().map((event) => event);

}