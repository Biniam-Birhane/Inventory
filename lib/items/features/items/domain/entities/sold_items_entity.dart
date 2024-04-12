import 'package:equatable/equatable.dart';

class SoldItem extends Equatable {
  const SoldItem({
    required this.id,
    required this.name,
    required this.amount,
    required this.unitPrice,
    required this.totalPrice,
    required this.paidPercentage,
    required this.paymentStatus,
    required this.deliveryStatus,
    required this.buyerName,
    required this.createdAt, //selling time
  });
  final String id;
  final String name;
  final int amount;
  final double unitPrice;
  final double totalPrice;
  final double paidPercentage;
  final String paymentStatus;
  final String deliveryStatus;
  final String buyerName;
  final DateTime createdAt;
  @override
  List<Object> get props => [
        id,
        name,
        amount,
        unitPrice,
        totalPrice,
        paidPercentage,
        paymentStatus,
        deliveryStatus,
        buyerName,
        createdAt
      ];
}
