import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';

class ProductSalesModel extends ProductSale {
  const ProductSalesModel(
      {required super.id,
      required super.buyerName,
      required super.productName,
      required super.amount,
      required super.totalCost,
      required super.paidAmount,
      required super.unPaidAmount,
      super.createdAt});

  factory ProductSalesModel.fromJson(String source) =>
      ProductSalesModel.fromMap(jsonDecode(source) as DataMap);

  ProductSalesModel.fromMap(DataMap map)
      : this(
            id: map['id'],
            buyerName: map['buyerName'],
            productName: map['productName'],
            amount: map['amount'],
            totalCost: map['totalCost'],
            paidAmount: map['paidAmount'],
            unPaidAmount: map['unPaidAmount'],
            createdAt: (map['createdAt'] as Timestamp)?.toDate());

  ProductSalesModel copyWith(
      {String? id,
      String? buyerName,
      String? productName,
      int? amount,
      double? totalCost,
      double? paidAmount,
      double? unPaidAmount,
      DateTime? createdAt}) {
    return ProductSalesModel(
        id: id ?? this.id,
        buyerName: buyerName ?? this.buyerName,
        productName: productName ?? this.productName,
        amount: amount ?? this.amount,
        totalCost: totalCost ?? this.totalCost,
        paidAmount: paidAmount ?? this.paidAmount,
        unPaidAmount: unPaidAmount ?? this.unPaidAmount,
        createdAt: createdAt ?? this.createdAt);
  }

  DataMap toMap() => {
        'id': id,
        'buyerName': buyerName,
        'productName': productName,
        'amount': amount,
        'totalCost': totalCost,
        'paidAmount': paidAmount,
        'unPaidAmount': unPaidAmount,
        'createdAt': Timestamp.fromDate(createdAt ?? DateTime.now()),
      };

  String toJson() => jsonEncode(toMap());
}
