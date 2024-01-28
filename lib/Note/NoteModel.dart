class NoteModel {
  String id;
  String title;
  String content;
  DateTime dateCreated;
  DateTime dateModified;

  NoteModel({
    required this.title,
    required this.id,
    required this.content,
    required this.dateCreated,
    required this.dateModified,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
        id: map["id"],
        title: map['title'],
        content: map['content'],
        dateCreated: DateTime.fromMillisecondsSinceEpoch(map['dateCreated']),
        dateModified: DateTime.fromMicrosecondsSinceEpoch(map['dataModified']));
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'dateCreated': dateCreated.microsecondsSinceEpoch,
      'dateModified': dateModified.microsecondsSinceEpoch,
    };
  }
}
