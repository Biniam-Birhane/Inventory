import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/reports/domain/usecases/get_daily_report.dart';
import 'package:simple_inventory/reports/domain/usecases/get_monthly_report.dart';
import 'package:simple_inventory/reports/domain/usecases/get_yearly_reports.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc(
      {required GetDailyReports dailyReports,
      required GetMonthlyReports monthlyReports,
      required GetYearlyReports yearlyReports})
      : _dailyReports = dailyReports,
        _monthlyReports = monthlyReports,
        _yearlyReports = yearlyReports,
        super(ReportsInitial()) {
    on<GetDailyReportsEvent>(_getDailyReportsHandler);
    on<GetMonthlyReportsEvent>(_getMonthlyReportsHandler);
    on<GetYearlyReportsEvent>(_getYearlyReportsHandler);
  }
  GetDailyReports _dailyReports;
  GetMonthlyReports _monthlyReports;
  GetYearlyReports _yearlyReports;

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
}
