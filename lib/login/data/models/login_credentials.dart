import 'dart:convert';

import 'package:simple_inventory/core/utils/typedef.dart';

import '../../domain/entities/login_credentials.dart';

class LoginCredentialsModel extends LoginCredentials {
  const LoginCredentialsModel({
    required super.username,
    required super.password,
  });

  factory LoginCredentialsModel.fromJson(String source) =>
      LoginCredentialsModel.fromMap(jsonDecode(source) as DataMap);

  LoginCredentialsModel.fromMap(DataMap map)
      : this(username: map["username"], password: map['password']);

  LoginCredentialsModel copyWith({
    String? id,
    String? name,
    String? description,
    String? avatar,
    double? price,
  }) {
    return LoginCredentialsModel(username: username, password: password);
  }

  DataMap toMap() => {
        'username': username,
        'password': password,
      };
  String toJson() => jsonEncode(toMap());
}
