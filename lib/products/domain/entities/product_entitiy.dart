import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  ProductEntity(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.unitPrice,
      required this.amount,required this.createdAt, this.date, this.month, this.year});
  final String id;
  final String productId;
  final String productName;
  final double unitPrice;
  final double amount;
  final DateTime? createdAt;
  final int? date;
  final int? month;
  final int? year;

  List<Object> get props => [id, productId, productName, unitPrice, amount];
}
