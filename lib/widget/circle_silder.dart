//import 'dart:ui';

import 'package:MovieReviewApp/page/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';

class CircleSlider extends StatelessWidget {
  final List<Movie> movies;
  const CircleSlider({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget>makeCircleImages(BuildContext,List<Movie> movies){
      List<Widget> results=[];
      int len=movies.length;
      for(int i=0; i<len; i++){
        results.add(
            InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute<Null>(
                      fullscreenDialog: true,
                      builder: (context){
                        return DetailScreen(movie: movies[i]);
                      }
                  ));
                },
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(movies[i].poster),
                      radius: 55,
                    ),
                  ),
               ))
        );
      }
      return results;
    }

    return Expanded(
        child:ListView(
            scrollDirection: Axis.horizontal,
            children:makeCircleImages(context,movies)
        )
    );
  }
}


