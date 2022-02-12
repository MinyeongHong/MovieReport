import 'dart:core';

class Review {
  final String? id;
  final String? user_title;
  final String? user_poster;
  final String? user_genre;
  final String? rate;
  final String? talk;
  final String? who;
  final String? time;
  final String? create_time;

  Review({this.id, this.user_title,this.user_poster,this.user_genre,this.rate, this.talk, this.who, this.time, this.create_time});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_title':user_title,
      'user_poster':user_poster,
      'user_genre':user_genre,
      'rate' : rate,
      'talk': talk,
      'who': who,
      'time': time,
      'create_time':create_time
    };
  }

  // 각 memo 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'Review{id: $id,user_title:$user_title,user_poster:$user_poster,user_genre:$user_genre, rate: $rate, talk: $talk, who: $who, time: $time, create_time:$create_time}';
  }
}