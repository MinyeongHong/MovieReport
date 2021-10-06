import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';

class BoxSlider extends StatelessWidget {
  final List<Movie> movies;
  const BoxSlider({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 595,
        color: Colors.blue[400],
        child:GridView.count(
          childAspectRatio: 2/3,
            crossAxisSpacing: 5,
            crossAxisCount: 3,
            scrollDirection: Axis.vertical,
            children: makeBoxImages(movies)
        )
    );
  }
}

List<Widget>makeBoxImages(List<Movie> movies){
  List<Widget> results=[];
  int len=movies.length;
  for(int i=0; i<len; i++){
    results.add(
        InkWell(
      onTap: (){},
      child:Image.network(movies[i].poster),
      )
    );

  }

  return results;
}
