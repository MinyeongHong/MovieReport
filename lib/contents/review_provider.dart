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

  Future<List<Review>> loadreview(int ver) async {
    return await sd.reviews(ver);
  }

  Future<void> editreview(Review review) async {
    notifyListeners();
    return await sd.update(review);

  }

  String str2sha512(String text) {
    var bytes = utf8.encode(text); // data being hashed
    var digest = sha512.convert(bytes);
    return digest.toString();
  }


}