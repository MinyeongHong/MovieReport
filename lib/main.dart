import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fourthflutter/page/home.dart';
import 'package:fourthflutter/page/my.dart';
import 'package:fourthflutter/widget/bottom_bar.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
/*
class App extends StatelessWidget {  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return LinearProgressIndicator(backgroundColor: Colors.black,);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return LinearProgressIndicator(backgroundColor: Colors.white,);
      },
    );
  }
}
*/

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
      theme:ThemeData(brightness: Brightness.dark,
          primaryColor: Colors.black,
      accentColor: Colors.white),
      home: DefaultTabController(length: 4,
        child: Scaffold(
          body:TabBarView(physics: NeverScrollableScrollPhysics(),
            children: [
              Homescreen(),
              MyRoom(),
              Container(),
              Container(),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}
