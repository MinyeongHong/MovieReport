import 'package:MovieReviewApp/contents/model_movie.dart';
import 'package:MovieReviewApp/page/searching.dart';
import 'package:MovieReviewApp/widget/auth_service.dart';
import 'package:MovieReviewApp/widget/bottom_bar.dart';
import 'package:MovieReviewApp/widget/box_slider.dart';
import 'package:MovieReviewApp/widget/carousel_slider.dart';
import 'package:MovieReviewApp/widget/circle_silder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'choosecategory.dart';
import 'my.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness:Brightness.dark, primaryColor: Colors.black),
        home: DefaultTabController(
          length: 4,
          child: SafeArea(
            child: Scaffold(
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Home(),
                  SearchScreen(),
                  Category(),
                  MyRoom(),
                ],
              ),
              bottomNavigationBar: Bottom(),
            ),
          ),
        ));
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final loginprovider = Provider.of<AuthServices>(context);
    return Scaffold(
      backgroundColor: Color(0xFF1D1E21),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Movier"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
             // color: Colors.white,
              child: Row(
                children: [
                  CircleAvatar(
                      backgroundImage: AssetImage('images/rectangle.png'),
                      radius: 35),
                  SizedBox(width: 10,),
                  Text(FirebaseAuth.instance.currentUser!.email.toString()),
                  TextButton(onPressed: (){loginprovider.logout();}, child: Text("로그아웃"))
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.bottomLeft,
            child: Text(
              "Netflix 인기 TV 프로그램",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Netflix_TV')
                      .orderBy('timestamp')
                      .limit(6)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator(color: Colors.white,));
                    return _buildBody(context, snapshot.data!.docs);
                  }),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.bottomLeft,
            child: Text("Netflix 인기 영화", style: TextStyle(fontSize: 20)),
          ),
          Expanded(
            child: Container(
              //  color: Colors.white,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Netflix_Movie')
                      .orderBy('timestamp')
                      .limit(6)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator(color: Colors.white,));
                    return _buildBody(context, snapshot.data!.docs);
                  }),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.bottomLeft,
            child: Text("최근 평가한 컨텐츠", style: TextStyle(fontSize: 20)),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Text("평가한 컨텐츠가 없습니다 !"),
          ))
        ],
      ),
    );
  }
}

Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
  List<Movie> movies = snapshot.map((d) => Movie.fromSnapshot(d)).toList();
  return Row(children: [
    CircleSlider(movies: movies),
  ]);
}
