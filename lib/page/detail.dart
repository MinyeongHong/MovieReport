import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';
import 'dart:ui';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  DetailScreen({required this.movie});
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool review=false;

  @override
  void initState() {
    super.initState();
    review = widget.movie.review;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child:SafeArea(
          child:ListView(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        image:DecorationImage(
                            image:AssetImage('images/'+widget.movie.poster),
                            fit:BoxFit.cover,
                        ),
                    ),

                  )
                ],
              ),
            makeMenuButton(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget makeMenuButton(){
  return Container();
}