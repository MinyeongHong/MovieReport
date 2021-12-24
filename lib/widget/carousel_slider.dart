import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';
import 'package:carousel_slider/carousel_slider.dart';

/*
class CarouselImage extends StatelessWidget {
  final List<Movie> movies;
  const CarouselImage({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
          ),
          CarouselSlider.builder(
            itemCount: 6,
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                Container(
                  child: Text(itemIndex.toString()),
                ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
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
              //children: makeIndicatior(likes, cur_page),
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
}*/