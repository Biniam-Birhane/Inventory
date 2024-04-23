import 'package:equatable/equatable.dart';

class ProductSale extends Equatable {
  const ProductSale(
      {required this.id,
      required this.buyerName,
      required this.productName,
      required this.amount,
      required this.totalCost,
      required this.paidAmount,
      required this.unPaidAmount,
      this.date,
      this.month,
      this.year,
      this.createdAt});
  final String id;
  final String buyerName;
  final String productName;
  final double amount;
  final double totalCost;
  final double paidAmount;
  final double unPaidAmount;
  final double? date;
  final double? month;
  final double? year;
  final DateTime? createdAt;
  @override
  List<Object> get props =>
      [id, buyerName, productName, amount, totalCost, paidAmount];
}
