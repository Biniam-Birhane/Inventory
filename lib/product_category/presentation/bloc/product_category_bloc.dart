import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_category_event.dart';
part 'product_category_state.dart';

class ProductCategoryBloc extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  ProductCategoryBloc() : super(ProductCategoryInitial()) {
    on<ProductCategoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
