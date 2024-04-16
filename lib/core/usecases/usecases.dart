import 'package:simple_inventory/core/utils/typedef.dart';

abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();
  ResultFuture<Type> call(Params params);
}

abstract class UsecasesWithoutParams<Type> {
  const UsecasesWithoutParams();
  ResultFuture<Type> call();
}
