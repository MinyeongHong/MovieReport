import 'package:MovieReviewApp/page/watchreview.dart';
import 'package:MovieReviewApp/page/writereview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_review.dart';
import 'package:MovieReviewApp/widget/user_db_helper.dart';
import 'package:MovieReviewApp/page/login.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';
import 'package:MovieReviewApp/widget/box_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
      backgroundColor: Color(0xFF1D1E21),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("내 리뷰함"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Container(child:
          TextButton(
            child:Text("새로고침"),
          onPressed: (){
              setState(() {

              });
          },),),
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
    return FutureBuilder(
        future: loadreview(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if ((snapshot.data as List).length == 0) {
              return Container(
                alignment: Alignment.center,
                child: Text("작성된 리뷰가 없습니다",style: TextStyle(fontSize: 15,),),
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
                      onTap: (){Navigator.push(parentContext,CupertinoPageRoute(builder: (context)=>ViewScreen(id:review.id)));},
                      child: Card(
                        color:Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),),
                          elevation: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 8,),
                              Opacity(
                                opacity: 0.9,
                                child: Image.network(review.user_poster.toString(),
                                    width:100,
                                    height:130,
                                    fit: BoxFit.fitWidth,
                                  ),
                              ),
                              Expanded(
                                child: Container(
                                //  color: Colors.red,
                                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 5,),
                                      Text(
                                        review.user_title.toString(),
                                        style: TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xFF8D0D0D)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 5,),
                                      RatingBarIndicator(
                                        unratedColor: Colors.grey,
                                        rating: double.parse(review.rate.toString()),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 40,
                                      ),
                                      SizedBox(height: 5,),
                                      IconButton(onPressed: (){}, icon: Icon(Icons.expand_more_sharp))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  child: IconButton(
                                    color: Colors.grey,
                                    alignment: Alignment.topRight,
                                    icon:Icon(Icons.clear), onPressed: () {  },
                                  ),
                                ),

                            ],
                          ),
                        ),
                    ),
                    SizedBox(height: 5,),
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
