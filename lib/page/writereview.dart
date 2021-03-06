import 'dart:io';

import 'package:MovieReviewApp/contents/model_review.dart';
import 'package:MovieReviewApp/widget/user_db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class ReviewScreen extends StatefulWidget {
  final Movie movie;
  const ReviewScreen({Key? key, required this.movie});
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  //InterstitialAd? _interstitialAd;
  DateTime _selectedDate = DateTime.now();
  late double rated;
  bool ckdate = false;
  String txt1 = 'myself';
  String txt2 = '';
  String u_title = '';
  String u_poster = '';
  String u_genre = '';
  String create_time = '';

  @override
  void initState() {
    super.initState();
   // _createInterstitialAd();
  }
/*
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: InterstitialAd.testAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InerstitialAd failed to load: $error.');
            _interstitialAd = null;
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdshowFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
*/
  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime.now())
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        ckdate = true;
      });
    });
  }

  @override
  Widget build(BuildContext parentcontext) {
    this.u_title = widget.movie.title;
    this.u_poster = widget.movie.poster;
    this.u_genre = widget.movie.genre.toString();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "?????? ????????????",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFFF5F5F1),
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Column(children: [
              Container(
                width: double.maxFinite,
                height: 260,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.movie.poster),
                        fit: BoxFit.fitHeight)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: Text(widget.movie.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFFF5F5F1),
                          fontWeight: FontWeight.bold))),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 0.5,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    rated = rating;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                height: 37,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          side: BorderSide(width: 1, color: Colors.grey)),
                      child: ckdate == false
                          ? Icon(
                              Icons.calendar_today,
                              color: Color(0xFFF5F5F1),
                              size: 21,
                            )
                          : Text(
                              new DateFormat.yMMMd().format(_selectedDate),
                              style: TextStyle(
                                  color: Color(0xFFF5F5F1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                      onPressed: () {
                        _presentDatePicker();
                      },
                    ),
                    Flexible(
                      flex: 1,
                      child: TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          labelText: '  with',
                          labelStyle: TextStyle(
                            color: Color(0xFFF5F5F1),
                            fontWeight: FontWeight.bold,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFFF5F5F1)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        style: TextStyle(
                            color: Color(0xFFF5F5F1),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        onChanged: (String txt1) {
                          this.txt1 = txt1;
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15, 15, 3, 15),
                  labelText: '  ?????????',
                  labelStyle: TextStyle(
                      color: Color(0xFFF5F5F1), fontWeight: FontWeight.bold),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xFFF5F5F1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onChanged: (String txt2) {
                  this.txt2 = txt2;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  shape: StadiumBorder(),
                  backgroundColor: Color(0xFFC92A2A),
                  primary: Colors.white,
                  shadowColor: Color(0xFF831010),
                  elevation: 3,
                ),
                child: Text("????????????",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF5F5F1))),
                onPressed: () {
                  saveDB();
                  Navigator.pop(parentcontext);
                },
              )
            ]),
          ),
        ));
  }

  Future<void> saveDB() async {
    bool sucess = true;
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
        create_time: DateTime.now().toString(),
      );
      await sd.insert(fido);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('????????? ??????????????????',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
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
      sucess = false;
    }
    if (sucess) {
      showDialog(
        context: context,

        barrierDismissible: true, // user must tap button!
        builder: (BuildContext alert_context) {
          return AlertDialog(
            content: Text("????????? ??????????????? ?????????????????????!"),

          );
        },

      );
    }

  }

  String str2sha512(String text) {
    var bytes = utf8.encode(text); // data being hashed
    var digest = sha512.convert(bytes);
    return digest.toString();
  }
}
