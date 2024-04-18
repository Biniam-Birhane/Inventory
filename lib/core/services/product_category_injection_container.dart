import 'package:get_it/get_it.dart';
import 'package:simple_inventory/product_category/data/datasources/remote_datasource.dart';
import 'package:simple_inventory/product_category/data/repositories/product_categories_rep_imp.dart';
import 'package:simple_inventory/product_category/domain/repositories/product_category_repository.dart';
import 'package:simple_inventory/product_category/domain/usecases/add_product_category.dart';
import 'package:simple_inventory/product_category/domain/usecases/delete_product_category.dart';
import 'package:simple_inventory/product_category/domain/usecases/get_product_category.dart';
import 'package:simple_inventory/product_category/domain/usecases/update_product_category.dart';
import 'package:simple_inventory/product_category/presentation/bloc/product_category_bloc.dart';

final pr = GetIt.instance;
Future<void> productCategoryInjection() async {
  pr
    ..registerFactory(() => ProductCategoryBloc(
        getProductCategoryUsecase: pr(),
        addProductCategoryUsecase: pr(),
        updateProductCategoryUsecase: pr(),
        deleteCategoryUsecase: pr()))
    ..registerLazySingleton(() => GetProductCategoryUsecase(pr()))
    ..registerLazySingleton(() => AddProductCategoryUsecase(pr()))
    ..registerLazySingleton(() => UpdateProductCategoryUsecase(pr()))
    ..registerLazySingleton(() => DeleteProductCategoryUsecase(pr()))
    ..registerLazySingleton<ProductCategoryRepository>(
        () => ProductCategoryRepImplimentation(pr()))
    ..registerLazySingleton<ProductCategoryRemoteDataSource>(
        () => ProductCategoryRemoteDataSourceImp());
}
