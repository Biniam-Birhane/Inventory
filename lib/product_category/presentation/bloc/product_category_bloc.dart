import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_inventory/product_category/domain/usecases/add_product_category.dart';
import 'package:simple_inventory/product_category/domain/usecases/delete_product_category.dart';
import 'package:simple_inventory/product_category/domain/usecases/get_product_category.dart';
import 'package:simple_inventory/product_category/domain/usecases/update_product_category.dart';

part 'product_category_event.dart';
part 'product_category_state.dart';

class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  ProductCategoryBloc(
      {required GetProductCategoryUsecase getProductCategoryUsecase,
      required AddProductCategoryUsecase addProductCategoryUsecase,
      required UpdateProductCategoryUsecase updateProductCategoryUsecase,
      required DeleteProductCategoryUsecase deleteCategoryUsecase})
      : _getProductCategoryUsecase = getProductCategoryUsecase,
        _addProductCategoryUsecase = addProductCategoryUsecase,
        _updateProductCategoryUsecase = updateProductCategoryUsecase,
        _deleteProductCategoryUsecase = deleteCategoryUsecase,
        super(ProductCategoryInitial()) {
    on<GetProductCategoryEvent>(getProductCategoryHandler);
    on<AddProductCategoryEvent>(addProductCategoryHandler);
    on<UpdateProductCategoryEvent>(updateProductCategoryHandler);
    on<DeleteProductCategoryEvent>(deleteProductCategoryHandler);
  }

  final GetProductCategoryUsecase _getProductCategoryUsecase;
  final AddProductCategoryUsecase _addProductCategoryUsecase;
  final UpdateProductCategoryUsecase _updateProductCategoryUsecase;
  final DeleteProductCategoryUsecase _deleteProductCategoryUsecase;

  void getProductCategoryHandler(
      GetProductCategoryEvent event, Emitter<ProductCategoryState> emit) async {
    // emit();
    await _getProductCategoryUsecase();
  }

  void addProductCategoryHandler(
      AddProductCategoryEvent event, Emitter<ProductCategoryState> emit) async {
    await _addProductCategoryUsecase(AddProductCategoryParams(
        id: event.id,
        productName: event.productName,
        availableAmount: event.availableAmount));
  }

  void updateProductCategoryHandler(UpdateProductCategoryEvent event,
      Emitter<ProductCategoryState> emit) async {
    await _updateProductCategoryUsecase(UpdateProductCategoryParam(
        id: event.id,
        productName: event.productName,
        availableAmount: event.availableAmount));
  }

  void deleteProductCategoryHandler(DeleteProductCategoryEvent event,
      Emitter<ProductCategoryState> emit) async {
    await _deleteProductCategoryUsecase(
        DeleteCategoryUsecaseParam(id: event.id));
  }
}
