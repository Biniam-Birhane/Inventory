import 'package:dartz/dartz.dart';
import 'package:simple_inventory/core/errors/failure.dart';
import 'package:simple_inventory/reports/presentation/pages/report_generating_service.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>;

typedef DataMap = Map<String, dynamic>;

 final PdfGeneratingService service = PdfGeneratingService();