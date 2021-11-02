import 'package:MovieReviewApp/page/choosecategory.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:MovieReviewApp/page/list.dart';
import 'package:MovieReviewApp/page/my.dart';
import 'package:MovieReviewApp/widget/bottom_bar.dart';

// 진빨강 Color(0xFF831010), 흰색 텍스트 Color(0xFFF5F5F1), 검정 Color(0xFF221F1F),
// 빨강 Color(0xFFE50914),
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'NetCha',
      theme:ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
      home: DefaultTabController(length: 4,
        child: SafeArea(
          child:Scaffold(
          body:TabBarView(physics: NeverScrollableScrollPhysics(),
            children: [
              Container(),
              Category(),
              Listscreen(),
              //MyRoom(),
              Container(),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
      )
    );
  }
}
