part of 'reports_bloc.dart';

class ReportsState extends Equatable {
  const ReportsState(
      {this.gettingReportStatus = FormzSubmissionStatus.initial,
      this.salesReport = const <ProductSale>[],
      this.reportTime = '',
      this.errorMessage = ''});
  final FormzSubmissionStatus gettingReportStatus;
  final List<ProductSale> salesReport;
  final String reportTime;
  final String errorMessage;

  ReportsState copyWith({
    FormzSubmissionStatus? gettingReportStatus,
    List<ProductSale>? salesReport,
    String? reportTime,
    String? errorMessage,
  }) {
    return ReportsState(
        errorMessage: errorMessage ?? this.errorMessage,
        gettingReportStatus: gettingReportStatus ?? this.gettingReportStatus,
        salesReport: salesReport ?? this.salesReport,
        reportTime: reportTime ?? this.reportTime);
  }

  @override
  List<Object> get props => [gettingReportStatus, salesReport, reportTime];
}

class ReportsInitial extends ReportsState {}
