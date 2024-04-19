import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/products_sales/domain/usecases/add_sale.dart';
import 'package:simple_inventory/products_sales/domain/usecases/delete_sale.dart';
import 'package:simple_inventory/products_sales/domain/usecases/get_sales.dart';
import 'package:simple_inventory/products_sales/domain/usecases/update_sale.dart';

part 'products_sales_event.dart';
part 'products_sales_state.dart';

class ProductsSalesBloc extends Bloc<ProductsSalesEvent, ProductsSalesState> {
  ProductsSalesBloc({
    required AddSale addSale,
    required GetSales getSales,
    required DeleteSale deleteSale,
    required UpdateSale updateSale,
  })  : _addSale = addSale,
        _getSales = getSales,
        _deleteSale = deleteSale,
        _updateSale = updateSale,
        super(const ProductsSalesState()) {
    on<AddSalesEvent>(_addSaleHandler);
    on<DeleteSaleEvent>(_deleteSaleHandler);
    on<UpdateSaleEvent>(_updateSaleHandler);
    on<GetSalesEvent>(_getSalesHandler);
    // }
  }
  final AddSale _addSale;
  final GetSales _getSales;
  final DeleteSale _deleteSale;
  final UpdateSale _updateSale;

  void _addSaleHandler(
      AddSalesEvent event, Emitter<ProductsSalesState> emit) async {
    emit(state.copyWith(addSalesStatus: FormzSubmissionStatus.inProgress));
    print(state.addSalesStatus);
    final result =
        await _addSale(AddSaleParams(productSale: event.productSale));
    result.fold(
        (failure) => emit(state.copyWith(
            addSalesStatus: FormzSubmissionStatus.failure,
            errorMessage: failure.errorMessage)),
        (_) => emit(
            state.copyWith(addSalesStatus: FormzSubmissionStatus.success)));
  }

  void _deleteSaleHandler(
      DeleteSaleEvent event, Emitter<ProductsSalesState> emit) async {
    emit(state.copyWith(deleteSalesStatus: FormzSubmissionStatus.inProgress));
    final result = await _deleteSale(DeleteSaleParams(id: event.id));
    result.fold(
        (failure) => emit(state.copyWith(
            deleteSalesStatus: FormzSubmissionStatus.failure,
            errorMessage: failure.errorMessage)),
        (_) => emit(
            state.copyWith(deleteSalesStatus: FormzSubmissionStatus.success)));
  }

  void _updateSaleHandler(
      UpdateSaleEvent event, Emitter<ProductsSalesState> emit) async {
    emit(state.copyWith(updateSalesStatus: FormzSubmissionStatus.inProgress));
    final result =
        await _updateSale(UpdateSaleParams(productSale: event.productSale));

    result.fold(
        (failure) => emit(state.copyWith(
            updateSalesStatus: FormzSubmissionStatus.failure,
            errorMessage: failure.errorMessage)),
        (_) => emit(
            state.copyWith(updateSalesStatus: FormzSubmissionStatus.success)));
  }

  Future<void> _getSalesHandler(
      GetSalesEvent event, Emitter<ProductsSalesState> emit) async {
    emit(state.copyWith(getSalesStatus: FormzSubmissionStatus.inProgress));

    final result = await _getSales();
    result.fold((failure) {
      emit(state.copyWith(
          getSalesStatus: FormzSubmissionStatus.failure,
          errorMessage: failure.errorMessage));
    }, (sales) {
      emit(state.copyWith(
          getSalesStatus: FormzSubmissionStatus.success,
          sales: sales,
          addSalesStatus: FormzSubmissionStatus.initial,
          deleteSalesStatus: FormzSubmissionStatus.initial,
          updateSalesStatus: FormzSubmissionStatus.initial,
          errorMessage: ''));
    });
  }
}
