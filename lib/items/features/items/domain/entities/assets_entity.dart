import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  const Asset(
      {required this.id,
      required this.name,
      required this.price,
      required this.availableAmount,
      required this.type,
      this.width,
      this.height});

  const Asset.empty()
      : this(
            id: 'empty_id',
            name: "empty_name",
            price: 0,
            availableAmount: 0,
            type: "empty_type");
  final String id;
  final String name;
  final double price;
  final int availableAmount;
  final String type;
  final double? width;
  final double? height;

  @override
  List<Object> get props => [id, name, price, availableAmount, type];
}
