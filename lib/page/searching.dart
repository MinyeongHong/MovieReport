import 'dart:ui';

import 'package:MovieReviewApp/contents/model_movie.dart';
import 'package:MovieReviewApp/page/detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  @override
  Widget build(BuildContext parentcontext) {
    return Container(
      color: Color(0xFF1D1E21),
        child: Column(
      children: [
        Container(
          color: Colors.black,
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            children: [
              Expanded(
                  flex: 6,
                  child: TextField(

                    onChanged: (val) {
                      setState(() {
                        _searchText = val;
                        print(_searchText);
                      });
                    },
                    focusNode: focusNode,
                    style: TextStyle(fontSize: 15),
                    autofocus: true,
                    controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      suffixIcon: focusNode.hasFocus
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _filter.clear();
                                  _searchText = "";
                                });
                              },
                              icon: Icon(
                                Icons.cancel,
                                size: 20,color: Colors.grey,
                              ))
                          : Container(),
                      hintText: '검색',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.transparent)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.transparent)),
                    ),
                  )),
              focusNode.hasFocus
                  ? Expanded(
                      child: TextButton(
                      onPressed: () {
                        setState(() {
                          _filter.clear();
                          _searchText = "";
                          focusNode.unfocus();
                        });
                      },
                      child: Text("취소",style: TextStyle(color: Colors.white),),
                    ))
                  : Expanded(flex: 0, child: Container())
            ],
          ),
        ),
        Container(padding: EdgeInsets.fromLTRB(0, 4, 0, 2),child: Text("영화"),),
        Expanded(
          child:Container(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Netflix_Movie")
                    .where("title", isGreaterThanOrEqualTo: _searchText).limit(4)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Something went wrong"),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) { return Center(child: CircularProgressIndicator(color: Colors.white,));}
                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      final movie = Movie.fromSnapshot(document);
                      return Card(
                        child: InkWell(
                            child: ListTile(
                              title: Text(movie.title),
                              leading: Image.network(movie.poster),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute<Null>(
                                  fullscreenDialog: true,
                                  builder: (BuildContext context) {
                                    return DetailScreen(movie: movie);
                                  }));
                            }),
                      );
                    }).toList(),
                  );
                }),
          ),
        ),
        Container(padding: EdgeInsets.fromLTRB(0, 2, 0, 2),child: Text("TV 프로그램"),),
        Expanded(
              child:Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Netflix_TV")
                      .where("title", isGreaterThanOrEqualTo: _searchText).limit(4)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Something went wrong"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) { return Center(child: CircularProgressIndicator(color: Colors.white,));}
                    return ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        final movie = Movie.fromSnapshot(document);
                        return Card(
                          child: InkWell(
                              child: ListTile(
                                title: Text(movie.title),
                                leading: Image.network(movie.poster),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute<Null>(
                                        fullscreenDialog: true,
                                        builder: (BuildContext context) {
                                          return DetailScreen(movie: movie);
                                        }));
                              }),
                        );
                      }).toList(),
                    );
                  }),
              ),
        ),

      ],
    ));
  }
}
