import 'dart:convert';

import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/product_category/domain/entities/product_category.dart';

class ProductCategoryModel extends ProductCategoryEntity {
  ProductCategoryModel(
      {required super.id,
      required super.productName,
      required super.availableAmount,
      required super.unitPrice});

  factory ProductCategoryModel.fromJson(String source) =>
      ProductCategoryModel.fromMap(jsonDecode(source) as DataMap);
  ProductCategoryModel.fromMap(DataMap map)
      : this(
            id: map['id'],
            productName: map['productName'],
            availableAmount: double.parse(map['availableAmount'].toString()),
            unitPrice: double.parse(map['unitPrice'].toString()));
  ProductCategoryModel copyWith(
      {String? id,
      String? productName,
      double? availableAmount,
      double? unitPrice}) {
    return ProductCategoryModel(
        id: id ?? this.id,
        productName: productName ?? this.productName,
        availableAmount: availableAmount ?? this.availableAmount,
        unitPrice: unitPrice ?? this.unitPrice);
  }

  DataMap toMap() => {
        'id': id,
        'productName': productName,
        "availableAmount": availableAmount,
        "unitPrice": unitPrice
      };
  String toJson() => jsonEncode(toMap());
}
