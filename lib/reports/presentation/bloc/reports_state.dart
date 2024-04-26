part of 'reports_bloc.dart';

class ReportsState extends Equatable {
  const ReportsState(
      {this.gettingReportStatus = FormzSubmissionStatus.initial,
      this.gettingProductReportStatus = FormzSubmissionStatus.initial,
      this.salesReport = const <ProductSale>[],
      this.productsReport = const <ProductEntity>[],
      this.reportTime = '',
      this.errorMessage = ''});
  final FormzSubmissionStatus gettingReportStatus;
  final FormzSubmissionStatus gettingProductReportStatus;
  final List<ProductSale> salesReport;
  final List<ProductEntity> productsReport;
  final String reportTime;
  final String errorMessage;

  ReportsState copyWith({
    FormzSubmissionStatus? gettingReportStatus,
    FormzSubmissionStatus? gettingProductReportStatus,
    List<ProductEntity>? productsReport,
    List<ProductSale>? salesReport,
    String? reportTime,
    String? errorMessage,
  }) {
    return ReportsState(
        errorMessage: errorMessage ?? this.errorMessage,
        gettingReportStatus: gettingReportStatus ?? this.gettingReportStatus,
        gettingProductReportStatus:
            gettingProductReportStatus ?? this.gettingProductReportStatus,
        productsReport: productsReport ?? this.productsReport,
        salesReport: salesReport ?? this.salesReport,
        reportTime: reportTime ?? this.reportTime);
  }

  @override
  List<Object> get props => [
        gettingReportStatus,
        gettingProductReportStatus,
        salesReport,
        productsReport,
        reportTime
      ];
}

class ReportsInitial extends ReportsState {}
