import 'package:equatable/equatable.dart';

class ProductCategoryEntity extends Equatable {
  ProductCategoryEntity(
      {required this.id,
      required this.productName,
      required this.availableAmount});
  final String id;
  final String productName;
  final double availableAmount;

  List<Object> get props => [id, productName, availableAmount];
}
