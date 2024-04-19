import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  ProductEntity(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.unitPrice,
      required this.amount});
  final String id;
  final String productId;
  final String productName;
  final double unitPrice;
  final double amount;

  List<Object> get props => [id, productId, productName, unitPrice, amount];
}
