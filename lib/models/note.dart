// ignore_for_file: public_member_api_docs, sort_constructors_first
class Note {
  final String id;
  final String userId;
  final String title;
  final String content;
  final DateTime dateAdded;

  Note(
      {required this.dateAdded,
      required this.id,
      required this.userId,
      required this.title,
      required this.content});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateAdded': dateAdded.millisecondsSinceEpoch.toString(),
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      dateAdded: DateTime.fromMillisecondsSinceEpoch(map['dateAdded']),
      id: map['id'] as String,
      userId: map['userId'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }
}
