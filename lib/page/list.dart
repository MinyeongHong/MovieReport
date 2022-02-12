import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:MovieReviewApp/contents/model_movie.dart';
import 'package:MovieReviewApp/widget/box_slider.dart';

class Listscreen extends StatefulWidget {
  const Listscreen({Key? key}) : super(key: key);

  @override
  _ListscreenState createState() => _ListscreenState();
}

class _ListscreenState extends State<Listscreen> {
  List<String> sorting_option = [
    "이름 순으로 보기",
    "이름 역 순으로 보기",
    "최신 순으로 보기",
    "오래된 순으로 보기",
  ];
  String now_title = "이름 순으로 보기";
  int now_option = 0;
  bool isExpand = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamData;

  @override
  void initState() {
    super.initState();
  }

  //스트림 데이터 추출해서 위젯으로 만듦
  Widget _fetchData(BuildContext context, List<String> pick, int sort_version) {
    print(pick[1][0] + pick[1][1]);
    if (pick[1][0] + pick[1][1] == '인기') {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(pick[0])
              .orderBy('timestamp')
              .limit(15)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ));
            return _buildBody(context, snapshot.data!.docs);
          });
    } else if (pick[1][0] + pick[1][1] == '최근') {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(pick[0])
              .where('update')
              .limit(15)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ));
            return _buildBody(context, snapshot.data!.docs);
          });
    } else {
      //if(sort_version==0)
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(pick[0])
              .where('genre', arrayContains: pick[1]).orderBy('timestamp',descending: true).limit(100)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ));
            return _buildBody(context, snapshot.data!.docs);
          });
      /*
      else if (sort_version==1) return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(pick[0])
              .where('genre', arrayContains: pick[1]).orderBy('name',descending: true).limit(30)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ));
            return _buildBody(context, snapshot.data!.docs);
          });
      else if (sort_version==2) return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(pick[0])
              .where('genre', arrayContains: pick[1]).orderBy('timestamp',descending: true).limit(30)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ));
            return _buildBody(context, snapshot.data!.docs);
          });
      else return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(pick[0])
              .where('genre', arrayContains: pick[1]).orderBy('timestamp').limit(30)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ));
            return _buildBody(context, snapshot.data!.docs);
          });
*/
    }
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Movie> movies = snapshot.map((d) => Movie.fromSnapshot(d)).toList();
    return Column(children: [
      BoxSlider(movies: movies),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final pick = ModalRoute.of(context)!.settings.arguments as List<String>;
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(pick[1]),
          backgroundColor: Colors.black,
        ),
        body: Column(children: [
          /*
          ExpansionTile(
            key: GlobalKey(),
            title: new Text(this.now_title),
            trailing: Icon(Icons.arrow_drop_down),
            children: [
              if (now_option != 0)
                new ListTile(
                  title: Text(sorting_option[0]),
                  onTap: () {
                    setState(() {
                      this.now_option = 0;
                      this.now_title = sorting_option[now_option];
                    });
                  },
                ),
              if (now_option != 1)
                new ListTile(
                  title: Text(sorting_option[1]),
                  onTap: () {
                    setState(() {
                      this.now_option = 1;
                      this.now_title = sorting_option[now_option];
                    });
                  },
                ),
              if (now_option != 2)
                new ListTile(
                  title: Text(sorting_option[2]),
                  onTap: () {
                    setState(() {
                      this.now_option = 2;
                      this.now_title = sorting_option[now_option];
                    });
                  },
                ),
              if (now_option != 3)
                new ListTile(
                  title: Text(sorting_option[3]),
                  onTap: () {
                    setState(() {
                      this.now_option = 3;
                      this.now_title = sorting_option[now_option];
                    });
                  },
                ),
            ],
          ),

           */
          Expanded(
            child: _fetchData(context, pick,this.now_option),
          )
        ]));
  }
}
