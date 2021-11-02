
import 'dart:ui';

import 'package:MovieReviewApp/page/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MovieReviewApp/widget/bottom_bar.dart';
import 'package:flutter/painting.dart';

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
    "Reality TV", //리얼리티 쇼로 고치기(파이썬도)
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
      appBar: AppBar(
        title: Text("영화 제목을 입력하세요",style: TextStyle(fontSize:15,color: Colors.grey[600]),),
        actions: [IconButton(onPressed: (){},icon: Icon(Icons.search,))],
      ),
      body: Column(
        children: [SizedBox(height: 5,),
          ToggleButtons(
          borderWidth: 2,
          borderRadius: BorderRadius.circular(5.5),
          renderBorder:true,
          isSelected:isSelected,
          selectedColor: Colors.white,
          textStyle: TextStyle(fontSize:17,fontWeight: FontWeight.normal),
          color: Color(0xFFF5F5F1),
          fillColor: Color(0x63E50914),
          children: [
            Padding(
              padding:const EdgeInsets.symmetric(),
              child: Text("영화"),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text("TV 프로그램"),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text("그 밖의 작품"),),
          ],
          onPressed: (int newIdx){
            setState(() {
              for(int i=0; i<isSelected.length; i++){
                if(i==newIdx) isSelected[i]=true;
                else isSelected[i]=false;
              }
            });
          },
        ),
          Expanded(
          child: ListView(
            children: ListTile.divideTiles(
                context: context,
                tiles: makeList(),
            ).toList(),
          ),
        )
    ],
      ),
    );
  }
}


