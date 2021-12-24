import 'package:cloud_firestore/cloud_firestore.dart';

class Movie{
  final String title;
  final List<String> genre;
  final String poster;
  final String year;
  final String description;
  final bool review;
  final DocumentReference reference;//파이어스토어 참조 링크

  Movie.fromMap(Map<String,dynamic> map, {required this.reference})
  :title = map['title'],
  year=map['year'],
  genre=List.from(map['genre']),
  poster=map['poster'],
  review=map['review'],
  description=map['description'];

  Movie.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data() as Map<String, dynamic>, reference:snapshot.reference);

  @override
  String toString() {
    // TODO: implement toString
    return "Movie<$title:$genre>";
  }

}
