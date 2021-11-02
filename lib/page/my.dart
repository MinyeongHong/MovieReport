import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';
import 'package:MovieReviewApp/widget/box_slider.dart';

class MyRoom extends StatefulWidget {
  const MyRoom({Key? key}) : super(key: key);

  @override
  _MyRoomState createState() => _MyRoomState();
}

class _MyRoomState extends State<MyRoom> {
 @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body:
        Column(
            children: <Widget>[
              SizedBox(height: 35,),
              Text('총 50편의 작품들을 평가했어요!',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              Text('취향 분석하러 가기',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: 25,),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text('  내가 평가한 컨텐츠', style: TextStyle(fontSize: 20),),
                    Container(
                padding: EdgeInsets.fromLTRB(15, 10, 5, 5),
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                 // children: makeBoxImages(seenmovies),
                ),
              ),
                    Text('  찜한 컨텐츠', style: TextStyle(fontSize: 20),),
                    Container(
                padding: EdgeInsets.fromLTRB(15, 10, 5, 0),
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
               //   children: makeBoxImages(seenmovies),
                ),
              )]),
            ],
          ),
      );

  }
}