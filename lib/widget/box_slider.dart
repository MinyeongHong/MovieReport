import 'dart:ui';

import 'package:MovieReviewApp/page/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';

class BoxSlider extends StatelessWidget {
  final List<Movie> movies;
  const BoxSlider({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget>makeBoxImages(BuildContext,List<Movie> movies){
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
            child:Column(
                children: [
                  Image.network(movies[i].poster),
                  Expanded(child:
                      Text(movies[i].title.toString(),maxLines: 1,overflow: TextOverflow.ellipsis,)
                  ),
                ],
              ),
          )
      );

    }

    return results;
  }

    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 660,
        color: Color(0xFF221F1F),
        child:GridView.count(
          childAspectRatio: 0.63,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            scrollDirection: Axis.vertical,
            children: makeBoxImages(context,movies)
        )
    );
  }
}


