import 'package:flutter/material.dart';
import 'package:fourthflutter/contents/model_movie.dart';

class BoxSlider extends StatelessWidget {
  final List<Movie> movies;
  const BoxSlider({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(' 최근 컨텐츠',style: TextStyle(fontSize: 20),),
          Container(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
            height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:makeBoxImages(movies),
              ),
          ),
          Text('  장르 별 컨텐츠',style: TextStyle(fontSize: 20),),
          Container(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:makeBoxImages(movies),
            ),
          )
        ],
      ),
    );

  }
}

List<Widget>makeBoxImages(List<Movie> movies){
  List<Widget> results=[];
  for(var i=0; i<movies.length; i++){
    results.add(InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Image.network(movies[i].poster)
  )
    )
    );
  }

  return results;
}
