part of 'items_bloc.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();  

  @override
  List<Object> get props => [];
}
class ItemsInitial extends ItemsState {}
