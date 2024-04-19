import 'package:get_it/get_it.dart';
import 'package:simple_inventory/product_category/data/datasources/remote_datasource.dart';
import 'package:simple_inventory/product_category/data/repositories/product_categories_rep_imp.dart';
import 'package:simple_inventory/product_category/domain/repositories/product_category_repository.dart';
import 'package:simple_inventory/product_category/domain/usecases/add_product_category.dart';
import 'package:simple_inventory/product_category/domain/usecases/delete_product_category.dart';
import 'package:simple_inventory/product_category/domain/usecases/get_product_category.dart';
import 'package:simple_inventory/product_category/domain/usecases/update_product_category.dart';
import 'package:simple_inventory/product_category/presentation/bloc/product_category_bloc.dart';
import 'package:simple_inventory/products/data/datasources/product_remote_datasource.dart';
import 'package:simple_inventory/products/data/repositories/product_repository_imp.dart';
import 'package:simple_inventory/products/domain/repositories/product_repository.dart';
import 'package:simple_inventory/products/domain/usecases/add_product_usecase.dart';
import 'package:simple_inventory/products/domain/usecases/delete_product_usecase.dart';
import 'package:simple_inventory/products/domain/usecases/get_products_usecase.dart';
import 'package:simple_inventory/products/domain/usecases/update_product_usecase.dart';
import 'package:simple_inventory/products/presentation/bloc/products_bloc.dart';

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

  pr
    ..registerFactory(() => ProductsBloc(
        getProductsUsecase: pr(),
        addProductUsecase: pr(),
        updateProductUsecase: pr(),
        deleteProductUsecase: pr()))
    ..registerLazySingleton(() => GetProductsUsecase(pr()))
    ..registerLazySingleton(() => AddProductUsecase(pr()))
    ..registerLazySingleton(() => UpdateProductUsecase(pr()))
    ..registerLazySingleton(() => DeleteProductUsecase(pr()))
    ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImp(pr()),
    )
    ..registerLazySingleton<ProductRemoteDatasource>(
      () => ProductRemoteDatasourceImp(),
    );
}
