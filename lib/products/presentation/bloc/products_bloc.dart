import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products/domain/usecases/add_product_usecase.dart';
import 'package:simple_inventory/products/domain/usecases/delete_product_usecase.dart';
import 'package:simple_inventory/products/domain/usecases/get_products_usecase.dart';
import 'package:simple_inventory/products/domain/usecases/update_product_usecase.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(
      {required GetProductsUsecase getProductsUsecase,
      required AddProductUsecase addProductUsecase,
      required UpdateProductUsecase updateProductUsecase,
      required DeleteProductUsecase deleteProductUsecase})
      : _getProductsUsecase = getProductsUsecase,
        _addProductUsecase = addProductUsecase,
        _updateProductUsecase = updateProductUsecase,
        _deleteProductUsecase = deleteProductUsecase,
        super(ProductsInitial()) {
    on<GetProductsEvent>(_getProductEventHandler);
    on<AddProductEvent>(_addProductEventHandler);
    on<DeleteProductEvent>(_deleteProductEventHandler);
    on<UpdateProductEvent>(_updateProductEventHandler);
  }
  final GetProductsUsecase _getProductsUsecase;
  final AddProductUsecase _addProductUsecase;
  final UpdateProductUsecase _updateProductUsecase;
  final DeleteProductUsecase _deleteProductUsecase;

  void _getProductEventHandler(
      GetProductsEvent event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(getProductsStatus: FormzSubmissionStatus.inProgress));
    final result = await _getProductsUsecase();
    result.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.errorMessage,
            getProductsStatus: FormzSubmissionStatus.failure)),
        (products) => emit(state.copyWith(
            getProductsStatus: FormzSubmissionStatus.success,
            products: products,
            addProductStatus: FormzSubmissionStatus.initial,
            updateProductStatus: FormzSubmissionStatus.initial,
            deleteProductStatus: FormzSubmissionStatus.initial)));
  }

  void _addProductEventHandler(
      AddProductEvent event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(addProductStatus: FormzSubmissionStatus.inProgress));
    final result = await _addProductUsecase(
        AddProductUsecaseParams(product: event.product));
    result.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.errorMessage,
            addProductStatus: FormzSubmissionStatus.failure)),
        (_) => emit(state.copyWith(
              addProductStatus: FormzSubmissionStatus.success,
            )));
  }

  void _updateProductEventHandler(
      UpdateProductEvent event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(updateProductStatus: FormzSubmissionStatus.inProgress));
    final result = await _updateProductUsecase(
        UpdateProductUsecaseParams(product: event.product));
    result.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.errorMessage,
            updateProductStatus: FormzSubmissionStatus.failure)),
        (_) => emit(state.copyWith(
              updateProductStatus: FormzSubmissionStatus.success,
            )));
  }

  void _deleteProductEventHandler(
      DeleteProductEvent event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(deleteProductStatus: FormzSubmissionStatus.inProgress));
    final result =
        await _deleteProductUsecase(DeleteProductUsecaseParams(id: event.id));
    result.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.errorMessage,
            deleteProductStatus: FormzSubmissionStatus.failure)),
        (_) => emit(state.copyWith(
              deleteProductStatus: FormzSubmissionStatus.success,
            )));
  }
}
