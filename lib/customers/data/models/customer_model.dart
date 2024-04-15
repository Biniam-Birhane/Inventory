import 'dart:convert';

import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/customers/domain/entities/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  const CustomerModel(
      {required super.id, required super.name, required super.phoneNumber});

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(jsonDecode(source) as DataMap);

  CustomerModel.fromMap(DataMap map)
      : this(id: map['id'], name: map['name'], phoneNumber: map['phoneNumber']);

  CustomerModel copyWith({String? id, String? name, String? phoneNumber}) {
    return CustomerModel(
        id: id ?? this.id,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber);
  }

  DataMap toMap() => {'id': id, 'name': name, "phoneNumber": phoneNumber};
  String toJson() => jsonEncode(toMap());
}
