import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';
import 'package:MovieReviewApp/widget/box_slider.dart';
import 'package:MovieReviewApp/widget/carousel_slider.dart';
import 'package:flutter/rendering.dart';

class Listscreen extends StatefulWidget {
  const Listscreen({Key? key}) : super(key: key);

  @override
  _ListscreenState createState() => _ListscreenState();
}

class _ListscreenState extends State<Listscreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late Stream<QuerySnapshot> streamData;
  @override
  void initState(){
    super.initState();
    streamData = firestore.collection('Netflix_movie').snapshots(); //스트림데이터 불러오기
  }

  //스트림 데이터 추출해서 위젯으로 만듦
  Widget _fetchData(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Netflix_movie').snapshots(),
      builder:(context,snapshot){
        if(!snapshot.hasData) return LinearProgressIndicator(backgroundColor: Colors.white,);
        return _buildBody(context,snapshot.data!.docs);
      }
    );
  }

  Widget _buildBody(BuildContext context,List<DocumentSnapshot> snapshot){
    List<Movie> movies = snapshot.map((d)=>Movie.fromSnapshot(d)).toList();
    return Container(
      child: Column(
          children: [
          TopBar(),
      BoxSlider(movies: movies),]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: (){},
            child: Text("영화",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
            style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10)
            ),
          ),
          TextButton(
            onPressed: (){},
            child: Text("TV 프로그램",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
            style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10)
            ),
          ),
          TextButton(
            onPressed: (){},
            child: Text("이외의 작품",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
            style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10)
            ),
          ),
        ],
      ),
    );
  }
}

