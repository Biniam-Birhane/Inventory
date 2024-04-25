import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products/presentation/bloc/products_bloc.dart';
import 'package:simple_inventory/products/presentation/widgets/add_products.dart';
import 'package:simple_inventory/products/presentation/widgets/update_products.dart';

class Products extends StatefulWidget {
  const Products({super.key});
  @override
  State<Products> createState() => ProductsScreenState();
}

class ProductsScreenState extends State<Products> {
  TextEditingController unitPrice = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<ProductEntity> searchedProducts = [];
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  void getProducts() {
    context.read<ProductsBloc>().add(const GetProductsEvent());
  }

  void searchProducts(String name, List<ProductEntity> products) {
    if (name.isEmpty) {
      setState(() {
        searchedProducts = products;
      });
    } else {
      final List<ProductEntity> result = products
          .where((product) =>
              product.productName.toLowerCase().contains(name.toLowerCase()))
          .toList();
      setState(() {
        searchedProducts = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ProductsBloc, ProductsState>(
        listener: (context, state) {
      if (state.getProductsStatus.isSuccess) {
        setState(() {
          searchedProducts = state.products;
        });
      }
      if (state.addProductStatus.isSuccess ||
          state.updateProductStatus.isSuccess ||
          state.deleteProductStatus.isSuccess) {
        getProducts();
      }
    }, builder: (context, state) {
      return Scaffold(
          backgroundColor: const Color(0xFF151D26),
          appBar: AppBar(
              backgroundColor: const Color(0xFF151D26),
              title: const Text(
                "Product Lists",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Quicksand",
                  fontSize: 20,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white)),
          body: state.getProductsStatus.isSuccess
              ? Column(children: [
                  searchField(size, state),
                  Expanded(
                      child: ListView.builder(
                          itemCount: searchedProducts.length,
                          itemBuilder: ((context, index) {
                            final product = searchedProducts[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: ExpansionTile(
                                  iconColor: Colors.white,
                                  dense: false,
                                  title: Text(
                                    product.productName,
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
                                              "Amount: ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Quicksand",
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              product.amount.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Quicksand",
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        'Unit Price:  ${product.unitPrice}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Quicksand",
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () => {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => UpdateProduct(
                                                              id: product.id,
                                                              productId: product
                                                                  .productId,
                                                              productName: product
                                                                  .productName,
                                                              amount: product
                                                                  .amount,
                                                              unitPrice: product
                                                                  .unitPrice)))
                                                },
                                            color: Colors.green,
                                            icon: const Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () {
                                              confirmDeletion(
                                                  context,
                                                  product.id,
                                                  product.productName);
                                            },
                                            color: Colors.red,
                                            icon: const Icon(Icons.delete))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })))
                ])
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddProduct(amount: amount, unitPrice: unitPrice)))
            },
            backgroundColor: const Color(0xFFFE8A00),
            elevation: 20,
            child: const Icon(
              Icons.add,
            ),
          ));
    });
  }

  Padding searchField(Size size, ProductsState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: size.width * 0.78,
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  searchProducts(value, state.products);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Search product",
                    prefixIcon: Icon(Icons.search),
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
            ElevatedButton(
              onPressed: () {},
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  backgroundColor: const Color(0xFFFE8A00),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            )
          ]),
    );
  }

  Future<dynamic> confirmDeletion(BuildContext context, id, productName) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm deletion"),
            content: Text(
              "Are you sure to delete ${productName}",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  context.read<ProductsBloc>().add(DeleteProductEvent(id: id));
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
