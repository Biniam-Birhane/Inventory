import 'dart:convert';

import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';

class ProductSalesModel extends ProductSale {
  const ProductSalesModel(
      {required super.id,
      required super.buyerName,
      required super.item,
      required super.amount,
      required super.totalCost,
      required super.paidAmount,
      super.createdAt});

  factory ProductSalesModel.fromJson(String source) =>
      ProductSalesModel.fromMap(jsonDecode(source) as DataMap);

  ProductSalesModel.fromMap(DataMap map)
      : this(
            id: map['id'],
            buyerName: map['buyerName'],
            item: map['item'],
            amount: map['amount'],
            totalCost: map['totalCost'],
            paidAmount: map['paidAmount'],
            createdAt: map['createdAt']);

  ProductSalesModel copyWith(
      {String? id,
      String? buyerName,
      String? item,
      int? amount,
      double? totalCost,
      double? paidAmount,
      DateTime? createdAt}) {
    return ProductSalesModel(
        id: id ?? this.id,
        buyerName: buyerName ?? this.buyerName,
        item: item ?? this.item,
        amount: amount ?? this.amount,
        totalCost: totalCost ?? this.totalCost,
        paidAmount: paidAmount ?? this.paidAmount,
        createdAt: createdAt ?? this.createdAt);
  }

  DataMap toMap() => {
        'id': id,
        'buyerName': buyerName,
        'item': item,
        'amount': amount,
        'totalCost': totalCost,
        'paidAmount': paidAmount,
        'createdAt': createdAt
      };

  String toJson() => jsonEncode(toMap());
}
