class NewsModel {
  final String? id;
  String title;
  String excerpt;
  String content;
  String category;
  String author;
  String date;
  String readTime;
  String imageUrl;
  bool isPublished;
  DateTime createdAt;
  DateTime updatedAt;

  NewsModel({
    this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.category,
    required this.author,
    required this.date,
    required this.readTime,
    this.imageUrl = '',
    this.isPublished = true,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'excerpt': excerpt,
      'content': content,
      'category': category,
      'author': author,
      'date': date,
      'readTime': readTime,
      'imageUrl': imageUrl,
      'isPublished': isPublished,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      id: map['id'],
      title: map['title'] ?? '',
      excerpt: map['excerpt'] ?? '',
      content: map['content'] ?? '',
      category: map['category'] ?? '',
      author: map['author'] ?? '',
      date: map['date'] ?? '',
      readTime: map['readTime'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      isPublished: map['isPublished'] ?? true,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  NewsModel copyWith({
    String? title,
    String? excerpt,
    String? content,
    String? category,
    String? author,
    String? date,
    String? readTime,
    String? imageUrl,
    bool? isPublished,
  }) {
    return NewsModel(
      id: id,
      title: title ?? this.title,
      excerpt: excerpt ?? this.excerpt,
      content: content ?? this.content,
      category: category ?? this.category,
      author: author ?? this.author,
      date: date ?? this.date,
      readTime: readTime ?? this.readTime,
      imageUrl: imageUrl ?? this.imageUrl,
      isPublished: isPublished ?? this.isPublished,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
