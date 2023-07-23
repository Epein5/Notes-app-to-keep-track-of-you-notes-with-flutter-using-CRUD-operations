class Notes {
  final int? id;
  final String? title;
  final String? description;

  Notes({ this.id, required this.title, required this.description});

  Notes.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        title = res['title'],
        description = res['description'];

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': description};
  }
}
