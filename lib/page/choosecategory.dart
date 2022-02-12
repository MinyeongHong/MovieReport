
import 'dart:ui';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:MovieReviewApp/page/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MovieReviewApp/widget/bottom_bar.dart';
import 'package:flutter/painting.dart';
import 'searching.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<bool> isSelected=[true,false,false];
  List<String> pick=["Netflix_Movie","액션"];
  final List<String> movie_kindof=<String>[
    "최근 등록된 영화",
    "인기 영화",
    "액션",
    "코미디",
    "가족",
    "로맨스",
    "드라마",
    "공포",
    "스릴러",
    "SF",
    "판타지",
    "리얼리티", //리얼리티로 고치기(파이썬도)
    "애니메이션",
    "다큐멘터리",
    "범죄",
    "서부",
    "스포츠",
    "역사",
    "음악",
    "전쟁",
  ];
  final List<String> TV_kindof=<String>[
    "최근 등록된 프로그램",
    "인기 프로그램",
    "액션",
    "코미디",
    "가족",
    "로맨스",
    "드라마",
    "공포",
    "스릴러",
    "SF",
    "판타지",
    "리얼리티",
    "애니메이션",
    "다큐멘터리",
    "범죄",
    "서부",
    "스포츠",
    "역사",
    "음악",
    "전쟁",
  ];
  final List<String> etc_kindof=[
    "상영중인 영화","영화 랭킹","직접 검색하기"];
  int labelIndex = 0;




  @override
  Widget build(BuildContext context) {
    List<Widget>makeList(){
      List<Widget> lists=[];
      List<String> l=[];
      if (isSelected[0]) {
        pick[0]="Netflix_Movie";
        l=movie_kindof;
      }
      else if (isSelected[1]) {
        pick[0]="Netflix_TV";
        l=TV_kindof;
      }
      else if (isSelected[2]){
        pick[0]="etc";
        l=etc_kindof;
      }

        for(int i=0; i<l.length; i++){
          lists.add(
            ListTile(
              title: Text('${l[i]}'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                pick[1]=l[i];
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context)=>Listscreen(),
                        settings:RouteSettings(arguments: pick)
                    )
                );
              },
            ),
          );
        }
        return lists;
      }

    return Scaffold(
      backgroundColor: Color(0xFF1D1E21),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("장르 별 컨텐츠 찾기"),
      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          ToggleSwitch(
            initialLabelIndex:labelIndex,
            minWidth: 150,
            cornerRadius: 20,
            activeBgColor: [Color(0xFFA32020)],
            activeFgColor: Colors.white,
            inactiveBgColor: Color(0x20FFFFFF),
            inactiveFgColor: Colors.white,
            totalSwitches: 2,
            labels: ['영화','TV 프로그램'],
            radiusStyle: true,
            animate: true,
            animationDuration: 170,
            onToggle: (index) {
              setState(() {
                labelIndex = index;
                for(int i=0; i<isSelected.length; i++){
                  if(i==index) isSelected[i]=true;
                  else isSelected[i]=false;
                }
              });},

          ),
          SizedBox(height: 10,),
          Expanded(
          child: ListView(
            children: ListTile.divideTiles(
                context: context,
                tiles: makeList(),
            ).toList(),
          ),
        )
      ],),
    );
  }
}


