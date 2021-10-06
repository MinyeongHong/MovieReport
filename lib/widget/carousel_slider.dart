import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImage extends StatefulWidget {
  final dynamic movies;
  CarouselImage({required this.movies});
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  late List<Movie> movies;
  late List<Widget> images;
  late List<String> keywords;
  late List<bool> review;
  late List<bool> likes;
  int cur_page=0;
  late String cur_keyword;

  @override
  void initState(){
    super.initState();
    movies = widget.movies;
    images=movies.map((e) => Image.asset('./images/'+e.poster)).toList();
    keywords=movies.map((e) => e.keyword).toList();
    review=movies.map((e) => e.review).toList();
    likes=movies.map((e) => e.like).toList();
    cur_keyword=keywords[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
          ),
          CarouselSlider(
              items: images,
              options: CarouselOptions(onPageChanged: (index,reason){
                setState(() {
                  cur_page=index;
                  cur_keyword=keywords[cur_page];
                });
              }),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              cur_keyword,
              style: TextStyle(fontSize: 11),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
                      if(likes[cur_page])
                        IconButton(onPressed:(){}, icon: Icon(Icons.check))
                      else
                        IconButton(onPressed:(){}, icon: Icon(Icons.add)),
                      Text('내가 찜한 컨텐츠', style: TextStyle(fontSize: 11),)
                      ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      IconButton(icon: Icon(Icons.star_rate_outlined), onPressed: (){}),
                      Text('별점', style: TextStyle(fontSize: 11),)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      IconButton(icon: Icon(Icons.info),
                      onPressed: (){}),
                      Text('정보',
                      style: TextStyle(fontSize: 11),),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: makeIndicatior(likes, cur_page),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> makeIndicatior(List list,int cur_page){
  List<Widget> result=[];
  for (int i=0; i<list.length; i++){
    result.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      color: cur_page== i? Color.fromRGBO(255, 255, 255, 0.9):Color.fromRGBO(255, 255, 255, 0.4) ),
    ));
  }

  return result;
}