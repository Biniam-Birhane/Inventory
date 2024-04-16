import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  const CustomerEntity(
      {required this.id, required this.name, required this.phoneNumber});
  final String id;
  final String name;
  final String phoneNumber;

  const CustomerEntity.empty()
      : this(
          id: 'empty_id',
          name: 'empty_name',
          phoneNumber: '0000000000',
        );

  @override
  List<Object> get props => [id, name, phoneNumber];
}
