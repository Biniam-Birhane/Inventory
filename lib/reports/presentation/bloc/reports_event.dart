part of 'reports_bloc.dart';

abstract class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object> get props => [];
}

class GetDailyReportsEvent extends ReportsEvent {
  const GetDailyReportsEvent(
      {required this.date, required this.month, required this.year});
  final int date;
  final int month;
  final int year;

  @override
  List<Object> get props => [date, month, year];
}

class GetMonthlyReportsEvent extends ReportsEvent {
  const GetMonthlyReportsEvent({required this.month, required this.year});
  final int month;
  final int year;
  @override
  List<Object> get props => [month, year];
}

class GetYearlyReportsEvent extends ReportsEvent {
  const GetYearlyReportsEvent({required this.year});

  final int year;
  @override
  List<Object> get props => [year];
}

class GetDailyProductReportsEvent extends ReportsEvent {
  const GetDailyProductReportsEvent(
      {required this.date, required this.month, required this.year});
  final int date;
  final int month;
  final int year;

  @override
  List<Object> get props => [date, month, year];
}

class GetMonthlyProductReportsEvent extends ReportsEvent {
  const GetMonthlyProductReportsEvent(
      {required this.month, required this.year});
  final int month;
  final int year;
  @override
  List<Object> get props => [month, year];
}

class GetYearlyProductReportsEvent extends ReportsEvent {
  const GetYearlyProductReportsEvent({required this.year});

  final int year;
  @override
  List<Object> get props => [year];
}
