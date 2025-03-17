import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/data/models/addrees_model.dart';
import 'package:t_store_admin_panel/data/models/user/cart_item_model.dart';

class OrderModel {
  final String? id;
  final String? userId;
  final OrderStatus? status;
  final double? totalAmount;
  final DateTime? orderDate;
  final String? paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel>? cartItems;

  OrderModel({
    this.id,
    this.userId,
    this.status,
    this.totalAmount,
    this.orderDate,
    this.paymentMethod,
    this.address,
    this.deliveryDate,
    this.cartItems,
  });

  String get formattedOrderDate => HelperFunctions.getFormattedDate(orderDate!);

  String get formattedDeliveryDate =>
      HelperFunctions.getFormattedDate(deliveryDate!);

  String get orderStatusText =>
      status == OrderStatus.delivered
          ? 'Delivered'
          : status == OrderStatus.shipped
          ? 'Shipped'
          : 'Processing';

  factory OrderModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;

    return OrderModel(
      id: json['id'] ?? '',
      userId: json['userId'],
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      totalAmount: json['totalAmount'],
      orderDate:
          json['orderDate'] is Timestamp
              ? (json['orderDate'] as Timestamp).toDate()
              : DateTime.tryParse(json['orderDate']) ?? DateTime.now(),
      paymentMethod: json['paymentMethod'],
      address: AddressModel.fromJson(json['address']),
      deliveryDate:
          json['deliveryDate'] is Timestamp
              ? (json['deliveryDate'] as Timestamp).toDate()
              : DateTime.tryParse(json['deliveryDate']) ?? DateTime.now(),
      cartItems: List<CartItemModel>.from(
        json['cartItems'].map((item) => CartItemModel.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'status': status.toString(),
    'totalAmount': totalAmount,
    'orderDate': orderDate,
    'paymentMethod': paymentMethod,
    'address': address?.toJson(),
    'deliveryDate': deliveryDate,
    'cartItems': List<dynamic>.from(
      cartItems?.map((item) => item.toJson()) ?? [],
    ),
  };

  static empty() {
    return OrderModel(
      id: '',
      userId: '',
      status: OrderStatus.processing,
      totalAmount: 0,
      orderDate: DateTime.now(),
      paymentMethod: '',
      address: AddressModel.empty(),
      deliveryDate: DateTime.now(),
      cartItems: [],
    );
  }
}
