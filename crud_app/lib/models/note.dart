class Note {
    final String id;
    final String title;
    final String content;
    final DateTime createdAt;

    Note({
        required this.id,
        required this.title,
        required this.content,
        required this.createdAt,
    });

    factory Note.fromJson(Map<String, dynamic> json) {
        final created = json['createdAt'];

        DateTime createdAt;

        if (created is Map) {
            createdAt = DateTime.fromMillisecondsSinceEpoch(
                (created['_seconds'] * 1000) + (created['_nanoseconds'] ~/ 1000000),
            );
        } else if (created is String) {
            createdAt = DateTime.parse(created);
        } else {
            createdAt = DateTime.now();
        }

        return Note(
            id: json['id'],
            title: json['title'],
            content: json['content'],
            createdAt: createdAt,
        );
    }
}

