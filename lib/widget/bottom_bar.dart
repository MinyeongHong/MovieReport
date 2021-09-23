import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Container(
        height: 65,
        child: TabBar(
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
                  Icons.perm_identity_rounded,
                  size:20,
                ),
                child:Text(
                  '내 리뷰함',
                  style: TextStyle(fontSize: 9),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.calendar_today,
                  size:20,
                ),
                child:Text(
                  '캘린더',
                  style: TextStyle(fontSize: 9),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.settings,
                  size:20,
                ),
                child:Text(
                  '설정',
                  style: TextStyle(fontSize: 9),
                ),
              )
            ]

        ),
      ),
    );
  }
}
