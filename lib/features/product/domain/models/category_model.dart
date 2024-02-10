class Category {
  final String title;
  final String id;

  Category({required this.title, required this.id});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      title: json['title'] as String,
      id: json['_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
    };
  }
}
