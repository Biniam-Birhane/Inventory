import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/customers/presentation/bloc/customers_bloc.dart';
import 'package:simple_inventory/product_category/presentation/bloc/product_category_bloc.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/products_sales/presentation/bloc/products_sales_bloc.dart';
import 'package:simple_inventory/products_sales/presentation/widgets/edit_sales.dart';
import 'package:uuid/uuid.dart';

class ProductSales extends StatefulWidget {
  const ProductSales({super.key});
  @override
  State<ProductSales> createState() => _ProductSaleScreen();
}

class _ProductSaleScreen extends State<ProductSales> {
  final List<String> sections = ["A", "B", "C"];
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

  final TextEditingController buyerNameController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final TextEditingController totalCostController = TextEditingController();
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController unPaidAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ProductsSalesBloc, ProductsSalesState>(
        listener: (context, state) {
      print(state.getSalesStatus);
      if (state.addSalesStatus.isSuccess ||
          state.updateSalesStatus.isSuccess ||
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
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: state.getSalesStatus.isInProgress
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.white,
                    ))
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.2,
                              child: const Text('Buyer',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            const Text('Product',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            const Text('Action',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.sales.length,
                            itemBuilder: (context, index) {
                              final soldProduct = state.sales[index];
                              return Container(
                                child: ListTile(
                                  dense: false,
                                  leading: Container(
                                    width: size.width * 0.2,
                                    child: Text(soldProduct.buyerName,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Quicksand",
                                            fontSize: 16)),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        '${soldProduct.amount} ',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "Quicksand",
                                            fontSize: 16),
                                      ),
                                      Text(
                                        soldProduct.productName,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Quicksand",
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'paid: ${soldProduct.paidAmount}',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "Quicksand",
                                            fontSize: 16),
                                      ),
                                      Text(
                                          'unpaid: ${soldProduct.unPaidAmount}',
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontFamily: "Quicksand",
                                              fontSize: 16)),
                                      Text(
                                          soldProduct.createdAt
                                              .toString()
                                              .substring(0, 10),
                                          style: const TextStyle(
                                              color: Colors.grey))
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) => EditSale(
                                                    soldProduct: soldProduct));
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            alertDelete(soldProduct);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                {showDialog(context: context, builder: (context) => addSale())},
            backgroundColor: const Color(0xFFFE8A00),
            elevation: 20,
            child: const Icon(
              Icons.add,
            ),
          ));
    });
  }

  Material addSale() {
    String selectedSection = sections[0];
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 86, 111, 140),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: buyerNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Enter buyer name",
                      labelText: "Buyer Name",
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
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
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: productNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Enter product name",
                      labelText: "product name",
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
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
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Enter amount",
                      labelText: "amount",
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
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
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: totalCostController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Enter total cost",
                      labelText: "Total Cost",
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
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
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: paidAmountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Enter paid amount",
                      labelText: "Paid amount",
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
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
                const SizedBox(
                  height: 20,
                ),
                DropdownButton<String>(
                  value: selectedSection,
                  items: sections
                      .map((section) => DropdownMenuItem<String>(
                            value: section,
                            child: Text(
                              "Section $section",
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    print(value!);
                    setState(() {
                      selectedSection = value;
                      print(selectedSection);
                    });
                  },
                ),
                submitButton()
              ],
            ),
          ),
        ),
      ),
    );
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

  BlocConsumer submitButton() {
    return BlocConsumer<ProductsSalesBloc, ProductsSalesState>(
        listener: (context, state) {
      print(state.addSalesStatus);
    }, builder: (context, state) {
      return state.addSalesStatus.isInProgress
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : ElevatedButton(
              onPressed: () {
                double totalCost =
                    double.tryParse(totalCostController.text) ?? 0;
                double paidAmount =
                    double.tryParse(paidAmountController.text) ?? 0;
                double unpaidAmount = totalCost - paidAmount;
                ProductSale productSale = ProductSale(
                    id: const Uuid().v4(),
                    buyerName: buyerNameController.text,
                    productName: productNameController.text,
                    amount: int.tryParse(amountController.text) ?? 0,
                    totalCost: totalCost,
                    paidAmount: paidAmount,
                    unPaidAmount: unpaidAmount);
                context
                    .read<ProductsSalesBloc>()
                    .add(AddSalesEvent(productSale: productSale));
                if (state.addSalesStatus.isSuccess) {
                  Navigator.pop(context);
                } else if (state.addSalesStatus.isFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.white),
                    ),
                    duration: const Duration(seconds: 5),
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFE8A00),
                  padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 10,
                    horizontal: 60,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text(
                "Submit",
                style: TextStyle(
                  fontFamily: "Quicksand",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
    });
  }
}
