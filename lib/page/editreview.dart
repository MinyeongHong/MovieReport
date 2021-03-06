import 'package:MovieReviewApp/contents/review_provider.dart';
import 'package:MovieReviewApp/contents/model_review.dart';
import 'package:MovieReviewApp/widget/user_db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  EditScreen({Key? key, required this.id}) : super(key: key);

  final String? id;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  DateTime new_selectedDate = DateTime.now();
  late String _selectedDate;

  bool ckdate = false;
  bool rebuild = false;
  double new_rated = 0.0;
  String rated = '';
  String create_time = '';
  String txt1 = '';
  String txt2 = '';

  String u_title = '';
  String u_poster = '';
  String u_genre = '';
  var txtWho = TextEditingController();
  var txtWhat = TextEditingController();

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            //locale: const Locale('ko', 'KO'),
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime.now())
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        new_selectedDate = pickedDate;
        ckdate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final review_manager = Provider.of<ReviewProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "내가 작성한 리뷰",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFF5F5F1),
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext alert_context) {
                        return AlertDialog(
                          title: Text('리뷰 삭제'),
                          content: Text("삭제하시겠습니까?"),
                          actions: <Widget>[
                            TextButton(
                              child: Text('예'),
                              onPressed: () {
                                Navigator.pop(alert_context, "예");
                                review_manager.deletereview(widget.id);
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('아니오'),
                              onPressed: () {
                                Navigator.pop(alert_context, "아니오");
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete)),
              IconButton(
                  onPressed: () {
                    if (new_rated != 0.0) rated = new_rated.toString();
                    if (ckdate) _selectedDate = new_selectedDate.toString();
                    var fido = Review(
                      id: widget.id,
                      user_title: this.u_title,
                      user_poster: this.u_poster,
                      user_genre: this.u_genre,
                      rate: rated.toString(),
                      who: this.txt1,
                      talk: this.txt2,
                      time: _selectedDate.toString(),
                      create_time: this.create_time,
                    );
                    review_manager.editreview(fido);
                    Navigator.of(context).pop();
                    ckdate = false;
                  },
                  icon: Icon(Icons.save)),
            ],
          ),
          body: SingleChildScrollView(
            child: LoadBuilder(),
          )),
    );
  }

  Future<List<Review>> loadreview(String? id) async {
    DBHelper sd = DBHelper();
    return await sd.findreview(id);
  }

  LoadBuilder() {
    return FutureBuilder<List<Review>>(
      future: loadreview(widget.id),
      builder: (BuildContext context, AsyncSnapshot<List<Review>> snapshot) {
        if (snapshot.data!.isEmpty) {
          return Container(
            child: Text("데이터를 불러올 수 없습니다"),
          );
        } else {
          Review review = snapshot.data![0];
          if (rebuild == false) {
            rebuild = true;
            _selectedDate = review.time!;
            create_time = review.create_time!;
            rated = review.rate!;
            txt1 = review.who!;
            txt2 = review.talk!;
            u_title = review.user_title!;
            u_genre = review.user_genre!;
            u_poster = review.user_poster!;

            txtWho.text = review.who!;
            txtWhat.text = review.talk!;
          }
          return Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Column(children: [
              Container(
                width: double.maxFinite,
                height: 260,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(review.user_poster.toString()),
                        fit: BoxFit.fitHeight)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(review.user_title.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFFF5F5F1),
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: RatingBar.builder(
                  initialRating: double.parse(review.rate.toString()),
                  minRating: 0.5,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    new_rated = rating;
                    print(new_rated);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                height: 37,
                //color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          side: BorderSide(width: 1, color: Colors.grey)),
                      child: (ckdate)
                          ? Text(
                              new DateFormat.yMMMd().format(
                                  DateTime.parse(new_selectedDate.toString())),
                              style: TextStyle(
                                  color: Color(0xFFF5F5F1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )
                          : Text(
                              new DateFormat.yMMMd().format(
                                  DateTime.parse(review.time.toString())),
                              style: TextStyle(
                                  color: Color(0xFFF5F5F1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                      onPressed: () {
                        _presentDatePicker();
                      },
                    ),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        controller: txtWho,
                        maxLines: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          labelText: '  with',
                          labelStyle: TextStyle(
                            color: Color(0xFFF5F5F1),
                            fontWeight: FontWeight.bold,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFFF5F5F1)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        style: TextStyle(
                            color: Color(0xFFF5F5F1),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        onChanged: (String txt1) {
                          this.txt1 = txt1;
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: txtWhat,
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15, 15, 3, 15),
                  labelText: '  감상평',
                  labelStyle: TextStyle(
                      color: Color(0xFFF5F5F1), fontWeight: FontWeight.bold),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xFFF5F5F1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onChanged: (String txt2) {
                  this.txt2 = txt2;
                  print(txtWhat.text);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "최근 업데이트 일: " + review.create_time.toString().substring(0, 10),
              )
            ]),
          );
        }
      },
    );
  }

}
