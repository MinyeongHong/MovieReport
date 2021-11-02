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
                        child: Container(
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
                                padding: EdgeInsets.all(3),
                                child: Text(widget.movie.genre.toString(),style: TextStyle(color: Color(0xFFF5F5F1)),),
                                ),
                              Container(
                      padding: EdgeInsets.all(7),
                      child: Text(widget.movie.title,textAlign: TextAlign.center,
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20) ),
                      ),
                      Container(
                        color: Colors.red,
                        padding: EdgeInsets.all(3),
                        child: TextButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                              fullscreenDialog: true,
                              builder: (context){
                                return ReviewScreen(movie: widget.movie);
                              }
                          ));
                        },
                        child:Text("리뷰 작성하기",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFFF5F5F1))),
                        ),
                      ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ),
                  Positioned(child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ))
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 5, 10, 15),
                    alignment: Alignment.center,
                    child: Text(widget.movie.description,style:TextStyle(color: Color(0xFFF5F5F1))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
