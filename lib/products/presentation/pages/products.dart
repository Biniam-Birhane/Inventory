import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
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
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  void getProducts() {
    context.read<ProductsBloc>().add(const GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ProductsBloc, ProductsState>(
        listener: (context, state) {
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
                  Expanded(
                      child: ListView.builder(
                          itemCount: state.products.length,
                          itemBuilder: ((context, index) {
                            final product = state.products[index];
                            return ListTile(
                              leading: Text("${index + 1}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Quicksand",
                                      fontSize: 20)),
                              title: Text(product.productName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Quicksand",
                                      fontSize: 20)),
                              subtitle: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("added amount",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Quicksand",
                                          )),
                                      Text(product.amount.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Quicksand",
                                              fontSize: 20)),
                                    ],
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Column(
                                    children: [
                                      const Text("unit Price",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Quicksand",
                                          )),
                                      Text(product.unitPrice.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Quicksand",
                                              fontSize: 20)),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () => {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateProduct(
                                                            id: product.id,
                                                            productId: product
                                                                .productId,
                                                            productName: product
                                                                .productName,
                                                            amount:
                                                                product.amount,
                                                            unitPrice: product
                                                                .unitPrice)))
                                          },
                                      color: Colors.green,
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        confirmDeletion(context, product.id,product.productName);
                                      },
                                      color: Colors.red,
                                      icon: const Icon(Icons.delete))
                                ],
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

  Future<dynamic> confirmDeletion(BuildContext context, id,productName) {
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
