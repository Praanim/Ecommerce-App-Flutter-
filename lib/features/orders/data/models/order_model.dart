class OrderModel {
  String userId;
  String product;
  String status;
  int quantity;
  double totalAmount;
  String transactionId;
  String id;

  OrderModel({
    required this.userId,
    required this.product,
    required this.status,
    required this.quantity,
    required this.totalAmount,
    required this.transactionId,
    required this.id,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      userId: json['userId'],
      product: json['product'],
      status: json['status'],
      quantity: json['quantity'],
      totalAmount: json['totalAmount'].toDouble(),
      transactionId: json['transactionId'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['product'] = product;
    data['status'] = status;
    data['quantity'] = quantity;
    data['totalAmount'] = totalAmount;
    data['transactionId'] = transactionId;
    data['_id'] = id;
    return data;
  }
}
