import 'package:cloud_firestore/cloud_firestore.dart';

class Movie{
  final String title;
  final String keyword;
  final String poster;
  final bool review;
  final bool like;
  final DocumentReference reference;//파이어스토어 참조 링크

  Movie.fromMap(Map<String,dynamic> map, {required this.reference})
  :title = map['title'],
  keyword=map['keyword'],
  poster=map['poster'],
  review=map['review'],
  like=map['like'];

  Movie.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data() as Map<String, dynamic>, reference:snapshot.reference);

  @override
  String toString() {
    // TODO: implement toString
    return "Movie<$title:$keyword>";
  }


}

