part of 'reports_bloc.dart';

abstract class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object> get props => [];
}

class GetDailyReportsEvent extends ReportsEvent {
  const GetDailyReportsEvent(
      {required this.date, required this.month, required this.year});
  final double date;
  final double month;
  final double year;

  @override
  List<Object> get props => [date, month, year];
}

class GetMonthlyReportsEvent extends ReportsEvent {
  const GetMonthlyReportsEvent({required this.month, required this.year});
  final double month;
  final double year;
  @override
  List<Object> get props => [month, year];
}

class GetYearlyReportsEvent extends ReportsEvent {
  const GetYearlyReportsEvent({required this.year});

  final double year;
  @override
  List<Object> get props => [year];
}
