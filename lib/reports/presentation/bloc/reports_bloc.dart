import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/reports/domain/usecases/get_daily_product_reports.dart';
import 'package:simple_inventory/reports/domain/usecases/get_daily_report.dart';
import 'package:simple_inventory/reports/domain/usecases/get_monthly_product_reports.dart';
import 'package:simple_inventory/reports/domain/usecases/get_monthly_report.dart';
import 'package:simple_inventory/reports/domain/usecases/get_yearly_product_reports.dart';
import 'package:simple_inventory/reports/domain/usecases/get_yearly_reports.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc({
    required GetDailyReports dailyReports,
    required GetMonthlyReports monthlyReports,
    required GetYearlyReports yearlyReports,
    required GetMonthlyProductReports monthlyProductReports,
    required GetDailyProductReports dailyProductReports,
    required GetYearlyProductReports yearlyProductReports,
  })  : _dailyReports = dailyReports,
        _monthlyReports = monthlyReports,
        _yearlyReports = yearlyReports,
        _dailyProductReports = dailyProductReports,
        _monthlyProductReports = monthlyProductReports,
        _yearlyProductReports = yearlyProductReports,
        super(ReportsInitial()) {
    on<GetDailyReportsEvent>(_getDailyReportsHandler);
    on<GetMonthlyReportsEvent>(_getMonthlyReportsHandler);
    on<GetYearlyReportsEvent>(_getYearlyReportsHandler);

    on<GetDailyProductReportsEvent>(_getDailyPoductReportsHandler);
    on<GetMonthlyProductReportsEvent>(_getMonthlyProductReportsHandler);
    on<GetYearlyProductReportsEvent>(_getYearlyProductReportsHandler);
  }
  final GetDailyReports _dailyReports;
  final GetMonthlyReports _monthlyReports;
  final GetYearlyReports _yearlyReports;
  final GetDailyProductReports _dailyProductReports;
  final GetMonthlyProductReports _monthlyProductReports;
  final GetYearlyProductReports _yearlyProductReports;

  Future<void> _getDailyReportsHandler(
      GetDailyReportsEvent event, Emitter<ReportsState> emit) async {
    emit(state.copyWith(gettingReportStatus: FormzSubmissionStatus.inProgress));
    final result = await _dailyReports(GetDailyReportsParams(
        date: event.date, month: event.month, year: event.year));
    result.fold(
        (failure) => emit(state.copyWith(
            gettingReportStatus: FormzSubmissionStatus.failure,
            errorMessage: failure.errorMessage)),
        (sales) => emit(state.copyWith(
            salesReport: sales,
            gettingReportStatus: FormzSubmissionStatus.success,
            errorMessage: '')));
  }

  Future<void> _getMonthlyReportsHandler(
      GetMonthlyReportsEvent event, Emitter<ReportsState> emit) async {
    emit(state.copyWith(gettingReportStatus: FormzSubmissionStatus.inProgress));
    final result = await _monthlyReports(
        GetMonthlyReportsParams(month: event.month, year: event.year));
    result.fold(
        (failure) => emit(state.copyWith(
            gettingReportStatus: FormzSubmissionStatus.failure,
            errorMessage: failure.errorMessage)),
        (sales) => emit(state.copyWith(
            gettingReportStatus: FormzSubmissionStatus.success,
            salesReport: sales,
            errorMessage: '')));
  }

  Future<void> _getYearlyReportsHandler(
      GetYearlyReportsEvent event, Emitter<ReportsState> emit) async {
    emit(state.copyWith(gettingReportStatus: FormzSubmissionStatus.inProgress));
    final result =
        await _yearlyReports(GetYearlyReportsParams(year: event.year));
    result.fold(
        (failure) => emit(state.copyWith(
            gettingReportStatus: FormzSubmissionStatus.failure,
            errorMessage: failure.errorMessage)),
        (sales) => emit(state.copyWith(
            gettingReportStatus: FormzSubmissionStatus.success,
            salesReport: sales,
            errorMessage: '')));
  }

  /// products report handlers

  Future<void> _getDailyPoductReportsHandler(
      GetDailyProductReportsEvent event, Emitter<ReportsState> emit) async {
    emit(state.copyWith(
        gettingProductReportStatus: FormzSubmissionStatus.inProgress));
    final result = await _dailyProductReports(GetDailyProductReportsParams(
        date: event.date, month: event.month, year: event.year));
    result.fold(
        (failure) => emit(state.copyWith(
            gettingProductReportStatus: FormzSubmissionStatus.failure,
            errorMessage: failure.errorMessage)),
        (products) => emit(state.copyWith(
            productsReport: products,
            gettingProductReportStatus: FormzSubmissionStatus.success,
            errorMessage: '')));
  }

  Future<void> _getMonthlyProductReportsHandler(
      GetMonthlyProductReportsEvent event, Emitter<ReportsState> emit) async {
    emit(state.copyWith(
        gettingProductReportStatus: FormzSubmissionStatus.inProgress));
    final result = await _monthlyProductReports(
        GetMonthlyProductReportsParams(month: event.month, year: event.year));
    result.fold(
        (failure) => emit(state.copyWith(
            gettingProductReportStatus: FormzSubmissionStatus.failure,
            errorMessage: failure.errorMessage)),
        (products) => emit(state.copyWith(
            gettingProductReportStatus: FormzSubmissionStatus.success,
            productsReport: products,
            errorMessage: '')));
  }

  Future<void> _getYearlyProductReportsHandler(
      GetYearlyProductReportsEvent event, Emitter<ReportsState> emit) async {
    emit(state.copyWith(
        gettingProductReportStatus: FormzSubmissionStatus.inProgress));
    final result = await _yearlyProductReports(
        GetYearlyProductReportsParams(year: event.year));
    result.fold(
        (failure) => emit(state.copyWith(
            gettingProductReportStatus: FormzSubmissionStatus.failure,
            errorMessage: failure.errorMessage)),
        (products) => emit(state.copyWith(
            gettingProductReportStatus: FormzSubmissionStatus.success,
            productsReport: products,
            errorMessage: '')));
  }
}
