import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/product_category/domain/entities/product_category.dart';
import 'package:simple_inventory/product_category/presentation/bloc/product_category_bloc.dart';
import 'package:simple_inventory/product_category/presentation/widgets/add_product_category.dart';
import 'package:simple_inventory/product_category/presentation/widgets/update_product_category.dart';

class ProductCategory extends StatefulWidget {
  ProductCategory({super.key});

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  late BuildContext dialogContext;
  TextEditingController _productName = TextEditingController();
  void getProductCategories() {
    context.read<ProductCategoryBloc>().add(GetProductCategoryEvent());
  }

  @override
  void initState() {
    getProductCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ProductCategoryBloc, ProductCategoryState>(
        listener: (context, state) {
      print(state.getProductCategoryStatus);
      if (state.addProductCategoryStatus.isSuccess ||
          state.updateProductCategoryStatus.isSuccess ||
          state.deleteProductCategoryStatus.isSuccess) {
        getProductCategories();
      }
    }, builder: (context, state) {
      return Scaffold(
          backgroundColor: Color(0xFF151D26),
          appBar: AppBar(
              backgroundColor: Color(0xFF151D26),
              title: const Text(
                "List of Product Categories",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Quicksand",
                  fontSize: 20,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.white)),
          body: state.getProductCategoryStatus.isSuccess
              ? Column(children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: state.productCategories.length,
                          itemBuilder: ((context, index) {
                            final productCategory =
                                state.productCategories[index];
                            return ListTile(
                              leading: Container(
                                width: size.width * 0.2,
                                child: Text("${index + 1}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Quicksand",
                                        fontSize: 20)),
                              ),
                              title: Text(productCategory.productName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Quicksand",
                                      fontSize: 20)),
                              subtitle: Text(
                                  productCategory.availableAmount.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Quicksand",
                                      fontSize: 20)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () => {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return UpdateProductCategory(
                                                    id: productCategory.id,
                                                    productName: productCategory
                                                        .productName,
                                                    availableAmount:
                                                        productCategory
                                                            .availableAmount,
                                                  );
                                                })
                                          },
                                      color: Colors.green,
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        confirmDeletion(
                                            context, productCategory);
                                      },
                                      color: Colors.red,
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            );
                          })))
                ])
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddProductCategory(
                      productName: _productName,
                    );
                  })
            },
            backgroundColor: Color(0xFFFE8A00),
            elevation: 20,
            child: const Icon(
              Icons.add,
            ),
          ));
    });
  }

  Future<dynamic> confirmDeletion(
      BuildContext context, ProductCategoryEntity productCategory) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm deletion"),
            content: Text(
              "Are you sure to delete ${productCategory.productName}",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  context
                      .read<ProductCategoryBloc>()
                      .add(DeleteProductCategoryEvent(id: productCategory.id));
                  Navigator.pop(context);
                },
                child: const Text(
                  "Yes",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)))
            ],
          );
        });
  }
}
