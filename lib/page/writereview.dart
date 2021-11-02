import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';
import 'dart:ui';

class ReviewScreen extends StatelessWidget {
  final Movie movie;
  const ReviewScreen({required this.movie}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("리뷰 작성하기",style: TextStyle(fontSize: 20,color: Color(0xFFF5F5F1),fontWeight: FontWeight.bold),),
      ),
      body:SingleChildScrollView(
        child:Container(
          child:Column(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 200,
                  decoration: BoxDecoration(
                      image:DecorationImage(
                          image:NetworkImage(movie.poster),fit: BoxFit.fitWidth)
                  ),),
                SizedBox(height: 10,),
                Text(movie.title,style: TextStyle(fontSize: 25,color: Color(0xFF831010),fontWeight: FontWeight.bold)),
                SizedBox(height: 10,),
                TextField(decoration: InputDecoration(
                      labelText: '  when',
                      labelStyle: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1,color: Colors.redAccent),
                      ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1,color: Color(0xFF831010)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),),
                SizedBox(height: 10,),
                TextField(decoration: InputDecoration(
                  labelText: '  where',
                  labelStyle: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1,color: Colors.redAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1,color: Color(0xFF831010)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),),
                SizedBox(height: 10,),
                TextField(decoration: InputDecoration(
                  labelText: '  with',
                  labelStyle: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1,color: Colors.redAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1,color: Color(0xFF831010)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),),
                SizedBox(height: 10,),
                TextField(maxLines: null,
                  decoration: InputDecoration(
                    labelText: '  감상평',
                    labelStyle: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1,color: Colors.redAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1,color: Color(0xFF831010)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),),
                ElevatedButton(onPressed:(){},
                    child: Text("등록하기"))
              ]
          ),
        ),
      )

    );
  }
}
