import 'package:eccomerce_frontend/features/home/domain/models/product_model.dart';

class Cart {
  String id;
  String user;
  List<Item> items;

  Cart({
    required this.id,
    required this.user,
    required this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> map) {
    return Cart(
        id: map['_id'],
        user: map['user'],
        items: (map['items'] as List<dynamic>)
            .map((itemMap) => Item.fromJson(itemMap))
            .toList());
  }
}

class Item {
  Product product;
  int quantity;

  Item({
    required this.product,
    required this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> map) {
    return Item(
      product: Product.fromJson(map['product']),
      quantity: map['quantity'],
    );
  }
}
