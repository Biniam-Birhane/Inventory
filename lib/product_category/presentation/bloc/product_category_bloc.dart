import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/product_category/domain/entities/product_category.dart';
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
    emit(state.copyWith(
        getProductCategoryStatus: FormzSubmissionStatus.inProgress));
    final result = await _getProductCategoryUsecase();
    result.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.errorMessage,
            getProductCategoryStatus: FormzSubmissionStatus.failure)),
        (productCategories) => emit(state.copyWith(
            getProductCategoryStatus: FormzSubmissionStatus.success,
            productCategories: productCategories,
            addProductCategoryStatus: FormzSubmissionStatus.initial,
            updateProductCategoryStatus: FormzSubmissionStatus.initial,
            deleteProductCategoryStatus: FormzSubmissionStatus.initial)));
  }

  void addProductCategoryHandler(
      AddProductCategoryEvent event, Emitter<ProductCategoryState> emit) async {
    emit(state.copyWith(
        addProductCategoryStatus: FormzSubmissionStatus.inProgress));
    final result = await _addProductCategoryUsecase(AddProductCategoryParams(
        id: event.id,
        productName: event.productName,
        availableAmount: event.availableAmount));
    result.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.errorMessage,
            addProductCategoryStatus: FormzSubmissionStatus.failure)),
        (_) => emit(state.copyWith(
            addProductCategoryStatus: FormzSubmissionStatus.success)));
  }

  void updateProductCategoryHandler(UpdateProductCategoryEvent event,
      Emitter<ProductCategoryState> emit) async {
    emit(state.copyWith(
        updateProductCategoryStatus: FormzSubmissionStatus.inProgress));
    final result = await _updateProductCategoryUsecase(
        UpdateProductCategoryParam(
            id: event.id,
            productName: event.productName,
            availableAmount: event.availableAmount));
    result.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.errorMessage,
            updateProductCategoryStatus: FormzSubmissionStatus.failure)),
        (_) => emit(state.copyWith(
            updateProductCategoryStatus: FormzSubmissionStatus.success)));
  }

  void deleteProductCategoryHandler(DeleteProductCategoryEvent event,
      Emitter<ProductCategoryState> emit) async {
    emit(state.copyWith(
        deleteProductCategoryStatus: FormzSubmissionStatus.inProgress));
    final result = await _deleteProductCategoryUsecase(
        DeleteCategoryUsecaseParam(id: event.id));
    result.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.errorMessage,
            deleteProductCategoryStatus: FormzSubmissionStatus.failure)),
        (r) => emit(state.copyWith(
            deleteProductCategoryStatus: FormzSubmissionStatus.success)));
  }
}
