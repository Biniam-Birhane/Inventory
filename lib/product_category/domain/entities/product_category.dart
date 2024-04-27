import 'package:equatable/equatable.dart';

class ProductCategoryEntity extends Equatable {
  ProductCategoryEntity(
      {required this.id,
      required this.productName,
      });
  final String id;
  final String productName;
  // final double availableAmount;
  // final double unitPrice;
  List<Object> get props => [id, productName, ];
}
