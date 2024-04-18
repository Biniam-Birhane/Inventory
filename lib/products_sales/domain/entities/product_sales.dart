import 'package:equatable/equatable.dart';

class ProductSale extends Equatable {
  const ProductSale(
      {required this.id,
      required this.buyerName,
      required this.item,
      required this.amount,
      required this.totalCost,
      required this.paidAmount,
      this.createdAt});
  final String id;
  final String buyerName;
  final String item;
  final int amount;
  final double totalCost;
  final double paidAmount;
  final DateTime? createdAt;
  @override
  List<Object> get props =>
      [id, buyerName, item, amount, totalCost, paidAmount];
}
