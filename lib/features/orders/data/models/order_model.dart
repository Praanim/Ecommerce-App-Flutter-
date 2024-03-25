import 'package:nattt_bazaar/features/auth/data/models/user.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';

class OrderModel {
  final String userId;
  final Product product;
  final String status;
  final int quantity;
  final double totalAmount;
  final String transactionId;
  final String? id;
  final AddressModel addressModel;

  OrderModel({
    required this.userId,
    required this.product,
    required this.status,
    required this.quantity,
    required this.totalAmount,
    required this.transactionId,
    required this.addressModel,
    this.id,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      userId: json['userId'],
      product: Product.fromJson(json['product']),
      status: json['status'],
      quantity: json['quantity'],
      totalAmount: json['totalAmount'].toDouble(),
      transactionId: json['transactionId'],
      id: json['_id'],
      addressModel: AddressModel.fromJson(json["address"]),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['product'] = product.id;
    data['status'] = status;
    data['quantity'] = quantity;
    data['totalAmount'] = totalAmount;
    data['transactionId'] = transactionId;
    data["address"] = addressModel.toJson();
    data['_id'] = id;
    return data;
  }
}
