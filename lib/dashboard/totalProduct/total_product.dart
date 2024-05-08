import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/product_category/domain/entities/product_category.dart';
import 'package:simple_inventory/product_category/presentation/bloc/product_category_bloc.dart';

class TotalProduct extends StatefulWidget {
  const TotalProduct({Key? key}) : super(key: key);

  @override
  State<TotalProduct> createState() => _TotalProductState();
}

class _TotalProductState extends State<TotalProduct> {
  List<ProductCategoryEntity> productCategories = [];

  Map<String, double> productTotals = {}; // Map to store product totals

  CollectionReference addProductCategoryTotal =
      FirebaseFirestore.instance.collection('products');
  CollectionReference soldProductCategoryTotal =
      FirebaseFirestore.instance.collection('sales');

  Future<void> getTotal(String productId) async {
    double addTotal = 0;
    double soldTotal = 0;

    QuerySnapshot addQuerySnapshot = await addProductCategoryTotal
        .where('productId', isEqualTo: productId)
        .get();
    QuerySnapshot soldQuerySnapshot = await soldProductCategoryTotal
        .where('productId', isEqualTo: productId)
        .get();

    for (QueryDocumentSnapshot addDoc in addQuerySnapshot.docs) {
      addTotal = addTotal + addDoc['amount'];
    }
    for (QueryDocumentSnapshot soldDoc in soldQuerySnapshot.docs) {
      soldTotal = soldTotal + soldDoc['amount'];
    }

    double total = addTotal - soldTotal;
    setState(() {
      productTotals[productId] = total; // Update the product totals map
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductCategoryBloc>().add(GetProductCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151D26),
      appBar: AppBar(
        backgroundColor: const Color(0xFF151D26),
        title: const Text(
          "Total Products",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Quicksand",
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<ProductCategoryBloc, ProductCategoryState>(
        listener: (context, state) {
          if (state.getProductCategoryStatus.isSuccess) {
            productCategories = state.productCategories;

            // Fetch totals for each product when the page is launched
            for (var product in productCategories) {
              getTotal(product.id);
            }
          }
        },
        builder: (context, state) {
          return state.getProductCategoryStatus.isSuccess
              ? ListView.builder(
                  itemCount: productCategories.length,
                  itemBuilder: (context, index) {
                    var productCategoryName =
                        productCategories[index].productName;
                    var productId = productCategories[index].id;

                    return ListTile(
                      leading: Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Quicksand",
                          fontSize: 20,
                        ),
                      ),
                      title: Text(
                        productCategoryName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Quicksand",
                          fontSize: 20,
                        ),
                      ),
                      trailing: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: productTotals[productId] != null && productTotals[productId]! < 30 ? Colors.red : Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          // Display total from the productTotals map
                          productTotals[productId]?.toString() ?? 'Loading...',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Quicksand",
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
