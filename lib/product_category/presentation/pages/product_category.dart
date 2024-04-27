import 'package:flutter/cupertino.dart';
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
  TextEditingController searchController = TextEditingController();
  List<ProductCategoryEntity> searchedProductCategories = [];
  void getProductCategories() {
    context.read<ProductCategoryBloc>().add(GetProductCategoryEvent());
  }

  @override
  void initState() {
    getProductCategories();
    super.initState();
  }

  void searchProductCategory(
      String name, List<ProductCategoryEntity> productCategories) {
    if (name.isEmpty) {
      setState(() {
        searchedProductCategories = productCategories;
      });
    } else {
      final List<ProductCategoryEntity> result = productCategories
          .where((category) =>
              category.productName.toLowerCase().contains(name.toLowerCase()))
          .toList();

      setState(() {
        searchedProductCategories = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ProductCategoryBloc, ProductCategoryState>(
        listener: (context, state) {
      if (state.getProductCategoryStatus.isSuccess) {
        setState(() {
          searchedProductCategories = state.productCategories;
        });
      }
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
                "Product Categories",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Quicksand",
                  fontSize: 20,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.white)),
          body: state.getProductCategoryStatus.isSuccess
              ? Column(children: [
                  searchField(size, state),
                  Expanded(
                      child: ListView.builder(
                          itemCount: searchedProductCategories.length,
                          itemBuilder: ((context, index) {
                            final productCategory =
                                searchedProductCategories[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: ExpansionTile(
                                  iconColor: Colors.white,
                                  dense: false,
                                  title: Text(
                                    productCategory.productName,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Quicksand",
                                        fontSize: 20),
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15.0, 0, 0, 0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: const Text(
                                              "Product name: ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Quicksand",
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              productCategory.productName
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Quicksand",
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () => {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return UpdateProductCategory(
                                                          id: productCategory
                                                              .id,
                                                          productName:
                                                              productCategory
                                                                  .productName,
                                                        );
                                                      })
                                                },
                                            color: Colors.grey,
                                            icon: Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () {
                                              confirmDeletion(
                                                  context, productCategory);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.grey,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
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

  Padding searchField(Size size, ProductCategoryState state) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: size.width * 0.76,
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  searchProductCategory(value, state.productCategories);
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Search product category",
                    prefixIcon: const Icon(Icons.search),
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    backgroundColor: const Color(0xFFFE8A00),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ]),
    );
  }
}
