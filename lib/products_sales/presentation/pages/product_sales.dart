import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/customers/presentation/bloc/customers_bloc.dart';
import 'package:simple_inventory/product_category/presentation/bloc/product_category_bloc.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/products_sales/presentation/bloc/products_sales_bloc.dart';
import 'package:simple_inventory/products_sales/presentation/widgets/add_product_sale.dart';
import 'package:simple_inventory/products_sales/presentation/widgets/edit_sales.dart';

class ProductSales extends StatefulWidget {
  const ProductSales({super.key});
  @override
  State<ProductSales> createState() => _ProductSaleScreen();
}

class _ProductSaleScreen extends State<ProductSales> {
  final List<String> sections = ["A", "B", "C"];
  TextEditingController searchController = TextEditingController();
  void getProductSale() {
    context.read<ProductsSalesBloc>().add(GetSalesEvent());
  }

  void getProductCategories() {
    context.read<ProductCategoryBloc>().add(const GetProductCategoryEvent());
  }

  void getCustomers() {
    context.read<CustomersBloc>().add(GetCustomersEvent());
  }

  @override
  void initState() {
    super.initState();
    getProductSale();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ProductsSalesBloc, ProductsSalesState>(
        listener: (context, state) {
      if (state.updateSalesStatus.isSuccess ||
          state.deleteSalesStatus.isSuccess) {
        getProductSale();
      }
    }, builder: (context, state) {
      return Scaffold(
          backgroundColor: const Color(0xFF151D26),
          appBar: AppBar(
            backgroundColor: const Color(0xFF151D26),
            title: const Text(
              "Product Sales",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Quicksand", fontSize: 20),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: state.getSalesStatus.isInProgress
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                ))
              : Column(
                  children: [
                    searchField(size),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.sales.length,
                        itemBuilder: (context, index) {
                          final soldProduct = state.sales[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: ExpansionTile(
                                iconColor: Colors.white,
                                dense: false,
                                leading: Container(
                                  width: size.width * 0.2,
                                  child: Text(soldProduct.buyerName,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Quicksand",
                                          fontSize: 16)),
                                ),
                                title: Text(
                                  soldProduct.productName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Quicksand",
                                      fontSize: 20),
                                ),
                                subtitle: Text(
                                  '${soldProduct.amount} ',
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Quicksand",
                                      fontSize: 16),
                                ),
                                children: [
                                  Text(
                                    soldProduct.createdAt.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Quicksand",
                                        fontSize: 16),
                                  ),
                                  ListTile(
                                    leading: Text(
                                      'Total Cost:   ${soldProduct.totalCost}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Quicksand",
                                      ),
                                    ),
                                    title: Text(
                                      'Paid:  ${soldProduct.paidAmount}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Quicksand",
                                      ),
                                    ),
                                    trailing: Text(
                                      'Unpaid: ${soldProduct.unPaidAmount}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Quicksand",
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    EditSales(
                                                        soldProduct:
                                                            soldProduct));
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.grey,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            alertDelete(soldProduct);
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
                        },
                      ),
                    ),
                  ],
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddProductSale()))
            },
            backgroundColor: const Color(0xFFFE8A00),
            elevation: 20,
            child: const Icon(
              Icons.add,
            ),
          ));
    });
  }

  Future<dynamic> alertDelete(ProductSale sale) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm deletion"),
            content: Text(
              "Are you sure you want to delete ${sale.productName}?",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  context
                      .read<ProductsSalesBloc>()
                      .add(DeleteSaleEvent(id: sale.id));
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

  Padding searchField(Size size) {
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
                      borderSide: const BorderSide(color: Colors.green, width: 2),
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
}
