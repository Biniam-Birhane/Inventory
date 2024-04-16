import 'dart:convert';

import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/product_category/domain/entities/product_category.dart';

class ProductCategoryModel extends ProductCategoryEntity {
  ProductCategoryModel(
      {required super.id,
      required super.productName,
      required super.availableAmount});

  factory ProductCategoryModel.fromJson(String source) =>
      ProductCategoryModel.fromMap(jsonDecode(source) as DataMap);
  ProductCategoryModel.fromMap(DataMap map)
      : this(
            id: map['id'],
            productName: map['productName'],
            availableAmount: map['availableAmount']);
  ProductCategoryModel copyWith(
      {String? id, String? productName, double? availableAmount}) {
    return ProductCategoryModel(
        id: id ?? this.id,
        productName: productName ?? this.productName,
        availableAmount: availableAmount ?? this.availableAmount);
  }

  DataMap toMap() => {
        'id': id,
        'productName': productName,
        "availableAmount": availableAmount
      };
  String toJson() => jsonEncode(toMap());
}
