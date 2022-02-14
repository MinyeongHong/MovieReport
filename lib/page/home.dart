import 'package:MovieReviewApp/contents/model_movie.dart';
import 'package:MovieReviewApp/contents/model_review.dart';
import 'package:MovieReviewApp/contents/review_provider.dart';
import 'package:MovieReviewApp/page/searching.dart';
import 'package:MovieReviewApp/widget/auth_service.dart';
import 'package:MovieReviewApp/widget/circle_silder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'choosecategory.dart';
import 'editreview.dart';
import 'list.dart';
import 'my.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
   return DefaultTabController(
          length: 4,
          child: SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
              backgroundColor: Color(0xFF1D1E21),
              body: Stack(
                children:[

                TabBarView(
                  physics: ClampingScrollPhysics(),
                  children: [
                    Home(),
                    SearchScreen(),
                    Category(),
                    MyRoom(),
                  ],
                ),]
              ),
              bottomNavigationBar: Container(
                color: Colors.black,
                child: Container(
                  height: 65,
                  child: TabBar(
                    physics: NeverScrollableScrollPhysics(),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white60,
                      indicatorColor: Colors.transparent,
                      tabs: <Widget>[
                        Tab(
                          icon: Icon(
                            Icons.home,
                            size:20,
                          ),
                          child:Text(
                            'Home',
                            style: TextStyle(fontSize: 9),
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.search,
                            size:20,
                          ),
                          child:Text(
                            '검색하기',
                            style: TextStyle(fontSize: 9),
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.list_sharp,
                            size:20,
                          ),
                          child:Text(
                            '작품 목록',
                            style: TextStyle(fontSize: 9),
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.perm_identity_rounded,
                            size:20,
                          ),
                          child:Text(
                            '내 리뷰함',
                            style: TextStyle(fontSize: 9),
                          ),
                        ),
                      ]

                  ),
                ),
              ),
            ),
          ),
        );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> pick =[];
  @override
  Widget build(BuildContext context) {
    final loginprovider = Provider.of<AuthServices>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF1D1E21),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Movier",style: TextStyle(fontSize: 30,),),
        actions: [Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
              child:Text(FirebaseAuth.instance.currentUser!.email.toString(),
                overflow: TextOverflow.visible,
                maxLines: null,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, height: 1.5),
              ),
            ),
            Divider(thickness: 0.3,color: Colors.grey,),
            ListTile(
              title: const Text('문의하기'),
              onTap: () async {
                  final url =
                      "https://docs.google.com/forms/d/e/1FAIpQLScdALR96Lobzyr_Mywma-0xon5FUHRwje-cLMxOYTYOU1Tn5A/viewform?usp=pp_url";
                  if (await canLaunch(url)) {
                await launch(
                url,
                forceWebView: true,
                enableJavaScript: true,
                );
                }
              },
            ),
            ListTile(
              title: const Text('로그아웃'),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext alert_context) {
                    return AlertDialog(
                      content: Text("정말 로그아웃 하시겠습니까?"),
                      actions: <Widget>[
                        TextButton(
                          child: Text('예',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          onPressed: () {
                            loginprovider.logout();
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('아니오',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          onPressed: () {
                            Navigator.pop(alert_context, "아니오");
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              title: const Text('회원 탈퇴'),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext alert_context) {
                    return AlertDialog(
                      content: Text("정말 탈퇴 하시겠습니까?"),
                      actions: <Widget>[
                        TextButton(
                          child: Text('예',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          onPressed: () {
                            loginprovider.removeAccount();
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('아니오',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          onPressed: () {
                            Navigator.pop(alert_context, "아니오");
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Netflix 인기 TV 프로그램",
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(onPressed: (){
                  pick =["Netflix_TV","인기"];
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context)=>Listscreen(),
                          settings:RouteSettings(arguments: pick)
                      )
                  );
                }, icon: Icon(Icons.arrow_forward))
              ],
            ),
          ),
          Flexible(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Netflix_TV')
                      .orderBy('timestamp')
                      .limit(6)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                    return _buildBody(context, snapshot.data!.docs);
                  }),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Netflix 인기 영화", style: TextStyle(fontSize: 20)),
                IconButton(onPressed: (){
                  pick =["Netflix_Movie","인기"];
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context)=>Listscreen(),
                          settings:RouteSettings(arguments: pick)
                      )
                  );
                }, icon: Icon(Icons.arrow_forward))
              ],
            ),
          ),
          Flexible(
            child: Container(
              //  color: Colors.white,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Netflix_Movie')
                      .orderBy('timestamp')
                      .limit(6)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                    return _buildBody(context, snapshot.data!.docs);
                  }),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("최근 평가한 컨텐츠", style: TextStyle(fontSize: 20)),
                IconButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>MyRoom())
                  );
                }, icon: Icon(Icons.arrow_forward))
              ],
            ),
          ),
          Flexible(child: reviewBuilder(context)),
          SizedBox(height: 10,),

        ],
      ),
    );
  }
}

Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
  List<Movie> movies = snapshot.map((d) => Movie.fromSnapshot(d)).toList();
  return Row(children: [
    CircleSlider(movies: movies),
  ]);
}

reviewBuilder(BuildContext parentContext) {
  final review_manager = Provider.of<ReviewProvider>(parentContext);
  return FutureBuilder(
      future: review_manager.loadreview(0),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          if ((snapshot.data as List).length == 0) {
            return Container(
              alignment: Alignment.center,
              child: Text("평가한 컨텐츠가 없습니다 !"),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 5),
            itemCount: (snapshot.data as List).length,
            itemBuilder: (context, index) {
              Review review = (snapshot.data as List)[index];
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      //  print({review.rate});
                      Navigator.push(
                          parentContext,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  EditScreen(id: review.id)));
                    },
                    child:Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(review.user_poster.toString()),
                          radius: 55,
                        ),
                      ),
                    )
                  ),
                ],
              );
            },
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Text('Loading'),
            ],
          ),
        );
      });
}

