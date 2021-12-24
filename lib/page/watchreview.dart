import 'dart:io';

import 'package:MovieReviewApp/contents/model_review.dart';
import 'package:MovieReviewApp/page/my.dart';
import 'package:MovieReviewApp/widget/user_db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ViewScreen extends StatefulWidget {
  ViewScreen({Key? key, required this.id}) : super(key: key);

  final String? id;

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  late DateTime _selectedDate;

  double rated = 0.0;

  bool ckdate = false;

  String txt1 = '';

  String txt2 = '';

  String u_title = '';

  String u_poster = '';

  String u_genre = '';

  Future<List<Review>> loadreview(String? id) async {
    DBHelper sd = DBHelper();
    return await sd.findreview(id);
  }

  Future<void> deletereview(String? id) async {
    DBHelper sd = DBHelper();
    await sd.delete(id);
  }

  LoadBuilder(){
    return FutureBuilder<List<Review>>(
      future: loadreview(widget.id),
      builder: (BuildContext context,AsyncSnapshot<List<Review>> snapshot){
        if(snapshot.data!.isEmpty){
          return Container(child: Text("데이터를 불러올 수 없습니다"),);
        }
        else{
          Review review = snapshot.data![0];
          return Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Column(children: [
              Container(
                width: double.maxFinite,
                height: 260,
                decoration: BoxDecoration(
                    image:DecorationImage(
                        image:NetworkImage(review.user_poster.toString()),fit: BoxFit.fitHeight)
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(review.user_title.toString(),
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFFF5F5F1),
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: RatingBar.builder(
                  initialRating: double.parse(review.rate.toString()),
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
                    print(rating);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                height: 37,
                //color: Colors.red,
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
                      child: (review.time!.isEmpty)
                          ? Icon(
                        Icons.calendar_today,
                        color: Color(0xFFF5F5F1),
                        size: 21,
                      )
                          : Text(
                        new DateFormat.yMMMd().format(DateTime.parse(review.time.toString())),
                        style: TextStyle(
                            color: Color(0xFFF5F5F1),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      onPressed: () {
                        // _presentDatePicker();
                      },
                    ),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        initialValue: review.who,
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
              TextFormField(
                initialValue: review.talk,
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15, 15, 3, 15),
                  labelText: '  감상평',
                  labelStyle: TextStyle(
                      color: Color(0xFFF5F5F1), fontWeight: FontWeight.bold),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                    BorderSide(width: 1, color: Color(0xFFF5F5F1)),
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
            ]),
          );
        }
      },
    );
  }

  void showAlertDialog(BuildContext context) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext _context) {
        return AlertDialog(
          title: Text('리뷰 삭제'),
          content: Text("삭제하시겠습니까?"),
          actions: <Widget>[
            TextButton(
              child: Text('예'),
              onPressed: () {
                Navigator.pop(_context, "예");
                setState(() {
                  deletereview(widget.id);
                Navigator.pop(context);

                });

                /*ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('리뷰가 성공적으로 등록되었습니다!',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
                    backgroundColor: Color(0xFF831010),
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
                );*/

              },
            ),
            TextButton(
              child: Text('아니오'),
              onPressed: () {
                Navigator.pop(_context, "아니오");
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "내가 작성한 리뷰",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFFF5F5F1),
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(onPressed: (){ updateDB(); }, icon: Icon(Icons.check)),
            IconButton(onPressed: (){
              showAlertDialog(context);
              //Navigator.pop(context);
            }, icon: Icon(Icons.delete))
          ],
        ),
        body: SingleChildScrollView(
          child: LoadBuilder(),
        ));
  }

  void updateDB(){
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
    Navigator.pop(context);
  }
}
