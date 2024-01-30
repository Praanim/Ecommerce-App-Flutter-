class Product {
  final String id;
  final String category;
  final String title;
  final String description;
  final int price;
  final List<String> images;
  final DateTime createdOn;
  final DateTime updatedOn;

  Product(
      {required this.id,
      required this.category,
      required this.title,
      required this.description,
      required this.price,
      required this.images,
      required this.createdOn,
      required this.updatedOn});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      images: (json['images'] as List<dynamic>).cast<String>(),
      createdOn: DateTime.parse(json['createdOn'] as String),
      updatedOn: DateTime.parse(json['updatedOn'] as String),
    );
  }
}
