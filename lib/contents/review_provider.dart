import 'dart:convert';
import 'package:MovieReviewApp/widget/user_db_helper.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model_review.dart';
//리뷰 데이터 관리 클래스
class ReviewProvider extends ChangeNotifier {
  final DBHelper sd = DBHelper();

  Future<void> deletereview(String? id) async {
    await sd.delete(id);
    notifyListeners();
  }

  Future<List<Review>> loadreview() async {
    return await sd.reviews();
  }

  Future<void> editreview(Review review) async {
    notifyListeners();
    return await sd.update(review);

  }

/*
  void updateDB() {
    DBHelper sd = DBHelper();
    var fido = Review(
      id: widget.id,
      user_title: this.u_title,
      user_poster: this.u_poster,
      user_genre: this.u_genre,
      rate: rated.toString(),
      who: this.txt1,
      talk: this.txt2,
      time: _selectedDate.toString(),
    );
    sd.update(fido);
  }

  Future<void> saveDB() async{
    bool sucess=true;
    try {
      DBHelper sd = DBHelper();
      var fido = Review(
        id: str2sha512(DateTime.now().toString()),
        user_title: this.u_title,
        user_poster: this.u_poster,
        user_genre: this.u_genre,
        rate: rated.toString(),
        who: this.txt1,
        talk: this.txt2,
        time: _selectedDate.toString(),
      );
      await sd.insert(fido);
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('별점을 입력해주세요',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,)),
          backgroundColor: Colors.white30,
          duration: Duration(milliseconds: 1000),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Colors.white70,
              width: 2,
            ),
          ),
        ),
      );
      // print(this.txt1);
      sucess=false;
    }

    if(sucess){
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(

          content: Text('리뷰가 성공적으로 등록되었습니다!',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
          backgroundColor: Color(0x831010),
          duration: Duration(milliseconds: 1000),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Color(0xFF831010),
              width: 2,
            ),
          ),
        ),
      );
      await Future.delayed(Duration(seconds: 1));

    }

  }*/

  String str2sha512(String text) {
    var bytes = utf8.encode(text); // data being hashed
    var digest = sha512.convert(bytes);
    return digest.toString();
  }


}