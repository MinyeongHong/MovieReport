import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';
import 'dart:ui';
import 'writereview.dart';

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
                            image:NetworkImage(widget.movie.poster),
                            fit:BoxFit.cover,
                        ),
                    ),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20,sigmaY: 20),
                        child: Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            alignment: Alignment.center,
                            color: Colors.black.withOpacity(0.4),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                                  child: Image.network(widget.movie.poster),
                                  height: 300,
                                ),
                                Container(
                                  width: 250,
                                  alignment: Alignment.center,
                                  padding:EdgeInsets.all(7),
                                  child: Text(widget.movie.genre.toString(),style: TextStyle(color: Color(0xFFF5F5F1),fontSize: 15),),
                                ),
                                Container(
                                  padding: EdgeInsets.all(7),
                                  child: Text(widget.movie.title,textAlign: TextAlign.center, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 27) ),
                                ),
                                if(widget.movie.year!=null) Text(widget.movie.year,style: TextStyle(color: Color(0xFFF5F5F1)),),
                                Flexible(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 1),
                                      padding: EdgeInsets.all(15),
                                      alignment: Alignment.center,
                                      child:  Text(widget.movie.description,
                                        style:TextStyle(color: Color(0xFFF5F5F1)),
                                        textAlign: TextAlign.left,)),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                      shape: StadiumBorder(),
                                      backgroundColor: Color(0xFFC92A2A),
                                      primary: Colors.white,
                                      shadowColor: Color(0xFF831010),
                                      elevation: 3,
                                    ),
                                    child: Text("평가하기",style: TextStyle(fontSize:17,fontWeight: FontWeight.bold,color: Color(0xFFF5F5F1))),
                                    onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute<Null>(
                                          fullscreenDialog: true,
                                          builder: (context){
                                            return ReviewScreen(movie: widget.movie);
                                          }
                                      ));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ),
                  Positioned(child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  )),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
