import 'dart:ui';

import 'package:MovieReviewApp/contents/review_provider.dart';
import 'package:MovieReviewApp/page/editreview.dart';
import 'package:MovieReviewApp/page/writereview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_review.dart';
import 'package:MovieReviewApp/widget/user_db_helper.dart';
import 'package:MovieReviewApp/page/auth_login.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';
import 'package:MovieReviewApp/widget/box_slider.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyRoom extends StatefulWidget {
  const MyRoom({Key? key}) : super(key: key);


  @override
  _MyRoomState createState() => _MyRoomState();
}

class _MyRoomState extends State<MyRoom> {
  int num = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF1D1E21),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("내 리뷰함"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            child: TextButton(
              child: Text("최신순으로 보기"),
              onPressed: () {
              },
            ),
          ),
          Expanded(
            child: reviewBuilder(context),
          )
        ],
      ),
    );
  }

  Future<List<Review>> loadreview() async {
    DBHelper sd = DBHelper();
    return await sd.reviews();

  }

  reviewBuilder(BuildContext parentContext) {
    final review_manager = Provider.of<ReviewProvider>(parentContext);
    return FutureBuilder(
      future: review_manager.loadreview(),
        //future: reviewlist,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if ((snapshot.data as List).length == 0) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  "작성된 리뷰가 없습니다",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 5),
              itemCount: (snapshot.data as List).length,
              itemBuilder: (context, index) {
                Review review = (snapshot.data as List)[index];
                return Column(
                  children: [
                    InkWell(
                        onTap: () {
                        //  print({review.rate});
                          Navigator.push(
                              parentContext,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      EditScreen(id: review.id)));
                        },
                        child: Card(
                          color: Color(0xFF686A79),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          child: Stack(children: [
                            Opacity(
                              opacity: 0.1,
                              child: Image.network(
                                review.user_poster.toString(),
                                width: 420,
                                height: 170,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      review.user_poster.toString(),
                                      height: 150,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        review.user_title.toString(),
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFF5F5F1)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      RatingBarIndicator(
                                        unratedColor: Colors.grey[300],
                                        rating: double.parse(
                                            review.rate.toString()),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 30,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding:
                                        EdgeInsets.fromLTRB(4, 2, 4, 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                            border: Border.all(
                                                width: 1,
                                                color: Color(0xFFF5F5F1))),
                                        child: Text(
                                          new DateFormat.yMMMd().format(
                                              DateTime.parse(
                                                  review.time.toString())) +
                                              ' with ' +
                                              review.who.toString(),
                                          style: TextStyle(
                                              color: Color(0xFFF5F5F1),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding:
                                          EdgeInsets.fromLTRB(4, 2, 4, 2),
                                          decoration: review.talk != ''
                                              ? BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Color(0xFFF5F5F1)))
                                              : null,
                                          child: Text(
                                            review.talk.toString(),
                                            style: TextStyle(
                                                color: Color(0xFFF5F5F1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ]),
                        ),
                      ),
                  ],
                );
              },
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Text('Loading'),
              ],
            ),
          );
        });
  }

}
