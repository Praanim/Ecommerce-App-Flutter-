class Product {
  final String id;
  final String category;
  final String title;
  final String description;
  final int price;
  final List<String> images;
  final Sales? sales;
  final DateTime createdOn;
  final DateTime updatedOn;

  Product(
      {required this.id,
      required this.category,
      required this.title,
      required this.description,
      required this.price,
      required this.images,
      required this.sales,
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
      sales: Sales.fromJson(json['sales']),
      createdOn: DateTime.parse(json['createdOn'] as String),
      updatedOn: DateTime.parse(json['updatedOn'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'category': category,
      'title': title,
      'description': description,
      'price': price,
      'images': images,
      'sales': sales?.toJson(), // Convert Sales object to JSON
    };
  }
}

class Sales {
  final int quantitySold;
  final int totalRevenue;

  Sales({required this.quantitySold, required this.totalRevenue});

  // Convert a JSON object to a Sales object
  factory Sales.fromJson(Map<String, dynamic> json) {
    return Sales(
      quantitySold: json['quantitySold'] as int,
      totalRevenue: json['totalRevenue'] as int,
    );
  }

  // Convert the Sales object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'quantitySold': quantitySold,
      'totalRevenue': totalRevenue,
    };
  }
}
