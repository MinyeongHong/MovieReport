import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fourthflutter/contents/model_movie.dart';
import 'package:fourthflutter/widget/box_slider.dart';
import 'package:fourthflutter/widget/carousel_slider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
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
    return ListView(
      padding: EdgeInsets.only(top: 25),
      children: [
        Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children:[
              Text('   APP TITLE', style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
              IconButton(
                padding: EdgeInsets.only(right: 5),
                icon:Icon(Icons.search_outlined),
                iconSize: 28,
                color: Colors.white,
                onPressed: (){
                  setState(() {
                    //페이지 변환
                  });
                },
              ),
            ]),
        TopBar(),
        BoxSlider(movies: movies),
      ],);
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
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
          padding: EdgeInsets.only(right: 1),
            child: TextButton(onPressed: () {
            },
              child: Text('넷플릭스',style: TextStyle(fontSize: 15,color: Colors.white),),),
        ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '왓챠',
              style: TextStyle(fontSize: 15),),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '이외의 영화',
              style: TextStyle(fontSize: 15),),
          ),
        ],
      ),
    );
  }
}

