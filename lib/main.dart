import 'package:MovieReviewApp/contents/review_provider.dart';
import 'package:MovieReviewApp/widget/auth_service.dart';
import 'package:MovieReviewApp/widget/auth_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthServices>.value(value: AuthServices()),
          StreamProvider<User>.value(
              value: AuthServices().user, initialData: null),
          ChangeNotifierProvider<ReviewProvider>.value(value: ReviewProvider(),),
        ],
        child: MaterialApp(
          theme:ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
            debugShowCheckedModeBanner: false, home: AuthenticationWrapper(),));
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Icon(Icons.error), Text("오류 발생")],
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
