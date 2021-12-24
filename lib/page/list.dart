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
//    streamData = firestore.collection('Contents').snapshots();
    //스트림데이터 불러오기
  }

  //스트림 데이터 추출해서 위젯으로 만듦
  Widget _fetchData(BuildContext context,List<String> pick){
    print(pick[1][0]+pick[1][1]);
    if(pick[1][0]+pick[1][1] == '인기'){
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(pick[0]).orderBy('timestamp').limit(15).snapshots(),
          builder:(context,snapshot){
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator(backgroundColor: Colors.white,));
            return _buildBody(context,snapshot.data!.docs);
          }
      );
    }
    else if(pick[1][0]+pick[1][1] == '최근'){
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(pick[0]).orderBy('timestamp').limit(15).snapshots(),
          builder:(context,snapshot){
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator(backgroundColor: Colors.white,));
            return _buildBody(context,snapshot.data!.docs);
          }
      );
    }
    else {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(pick[0]).where('genre',arrayContains: pick[1]).snapshots(),
          builder:(context,snapshot){
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator(backgroundColor: Colors.white,));
            return _buildBody(context,snapshot.data!.docs);
          }
      );
    }

  }

  Widget _buildBody(BuildContext context,List<DocumentSnapshot> snapshot){
    List<Movie> movies = snapshot.map((d)=>Movie.fromSnapshot(d)).toList();
    return Column(
          children: [BoxSlider(movies: movies),]
    );
  }

  @override
  Widget build(BuildContext context) {
    final pick = ModalRoute.of(context)!.settings.arguments as List<String>;
    return Scaffold(
      appBar: AppBar(
        title: Text(pick[1]),
        backgroundColor: Colors.black,
      ),
      body: _fetchData(context,pick)
    );
  }
}
