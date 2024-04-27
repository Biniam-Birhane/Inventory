import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {required super.id,
      required super.productId,
      required super.productName,
      required super.amount,
      required super.unitPrice,
      required super.createdAt,
      super.date,
      super.month,
      super.year});

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(jsonDecode(source) as DataMap);

  ProductModel.fromMap(DataMap map)
      : this(
            id: map['id'],
            productId: map['productId'],
            productName: map['productName'],
            amount: double.parse(map['amount'].toString()),
            unitPrice: double.parse(map['unitPrice'].toString()),
            createdAt: (map['createdAt'] as Timestamp).toDate(),
            date: map['date'],
            month: map['month'],
            year: map['year']);
  ProductModel copyWith(
      {String? id,
      String? productId,
      String? productName,
      double? amount,
      double? unitPrice,
      DateTime? createdAt,
      int? date,
      int? month,
      int? year}) {
    return ProductModel(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        amount: amount ?? this.amount,
        unitPrice: unitPrice ?? this.unitPrice,
        createdAt: createdAt ?? this.createdAt,
        date: date ?? this.date,
        month: month ?? this.month,
        year: year ?? this.year);
  }

  DataMap toMap() => {
        'id': id,
        'productId': productId,
        'productName': productName,
        "amount": amount,
        "unitPrice": unitPrice
      };
  String toJson() => jsonEncode(toMap());
}
