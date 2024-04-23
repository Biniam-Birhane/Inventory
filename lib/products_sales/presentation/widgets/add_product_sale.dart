import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/customers/presentation/bloc/customers_bloc.dart';
import 'package:simple_inventory/product_category/presentation/bloc/product_category_bloc.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/products_sales/presentation/bloc/products_sales_bloc.dart';
import 'package:uuid/uuid.dart';

class AddProductSale extends StatefulWidget {
  const AddProductSale({super.key});
  @override
  State<AddProductSale> createState() => _AddSaleScreen();
}

class _AddSaleScreen extends State<AddProductSale> {
  String? selectedProduct;
  List<String> products = [];

  String? selectedCustomer;
  List<String> customers = [];
  void getCustomers() {
    context.read<CustomersBloc>().add(GetCustomersEvent());
  }

  void getProductCategories() {
    context.read<ProductCategoryBloc>().add(const GetProductCategoryEvent());
  }

  @override
  void initState() {
    super.initState();
    getCustomers();
    getProductCategories();
  }

  final TextEditingController buyerNameController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final TextEditingController totalCostController = TextEditingController();
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController unPaidAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151D26),
      appBar: AppBar(
        backgroundColor: const Color(0xFF151D26),
        title: const Text(
          'Add sold Materials',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<ProductCategoryBloc, ProductCategoryState>(
                  listener: (context, state) {
                    if (state.getProductCategoryStatus.isSuccess) {
                      for (var i = 0; i < state.productCategories.length; i++) {
                        String productName =
                            state.productCategories[i].productName;
                        products.add(productName);
                      }
                    }
                  },
                  builder: (context, state) {
                    return state.getProductCategoryStatus.isSuccess
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton(
                                dropdownColor:
                                    const Color.fromARGB(255, 49, 72, 101),
                                hint: const Text(
                                  "Select product :",
                                  style: TextStyle(color: Colors.white),
                                ),
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 36,
                                isExpanded: true,
                                underline: const SizedBox(),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                value: selectedProduct,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedProduct = newValue;
                                  });
                                },
                                items: products.map((product) {
                                  return DropdownMenuItem(
                                      value: product,
                                      child: Text(product,
                                          style: const TextStyle(
                                              color: Colors.white)));
                                }).toList()),
                          )
                        : const CircularProgressIndicator();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<CustomersBloc, CustomersState>(
                  listener: (context, state) {
                    if (state.getCustomerStatus.isSuccess) {
                      for (var i = 0; i < state.customers.length; i++) {
                        String customerName = state.customers[i].name;
                        customers.add(customerName);
                      }
                    }
                  },
                  builder: (context, state) {
                    return state.getCustomerStatus.isSuccess
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton(
                                dropdownColor:
                                    const Color.fromARGB(255, 49, 72, 101),
                                hint: const Text("Select Customer :",
                                    style: TextStyle(color: Colors.white)),
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 36,
                                isExpanded: true,
                                underline: const SizedBox(),
                                style: const TextStyle(
                                    color: Colors.white10, fontSize: 18),
                                value: selectedCustomer,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCustomer = newValue;
                                  });
                                },
                                items: customers.map((customer) {
                                  return DropdownMenuItem(
                                      value: customer,
                                      child: Text(
                                        customer,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ));
                                }).toList()),
                          )
                        : const CircularProgressIndicator();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // TextField(
                //   controller: buyerNameController,
                //   style: const TextStyle(color: Colors.white),
                //   decoration: InputDecoration(
                //       hintText: "Enter buyer name",
                //       labelText: "Buyer Name",
                //       hintStyle: const TextStyle(color: Colors.grey),
                //       labelStyle: const TextStyle(
                //           color: Colors.white,
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         borderSide: BorderSide(
                //           color: Colors.grey.withOpacity(0.5),
                //           width: 1.5,
                //         ),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide:
                //             const BorderSide(color: Colors.green, width: 2),
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       floatingLabelBehavior: FloatingLabelBehavior.always),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // TextField(
                //   controller: productNameController,
                //   style: const TextStyle(color: Colors.white),
                //   decoration: InputDecoration(
                //       hintText: "Enter product name",
                //       labelText: "product name",
                //       hintStyle: const TextStyle(color: Colors.grey),
                //       labelStyle: const TextStyle(
                //           color: Colors.white,
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         borderSide: BorderSide(
                //           color: Colors.grey.withOpacity(0.5),
                //           width: 1.5,
                //         ),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide:
                //             const BorderSide(color: Colors.green, width: 2),
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       floatingLabelBehavior: FloatingLabelBehavior.always),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
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
                // DropdownButton<String>(
                //   value: selectedSection,
                //   items: sections
                //       .map((section) => DropdownMenuItem<String>(
                //             value: section,
                //             child: Text(
                //               "Section $section",
                //             ),
                //           ))
                //       .toList(),
                //   onChanged: (value) {
                //     print(value!);
                //     setState(() {
                //       selectedSection = value;
                //       print(selectedSection);
                //     });
                //   },
                // ),

                submitButton()
              ],
            ),
          ),
        ),
      ),
    );
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
                    buyerName: selectedCustomer ?? '',
                    productName: selectedProduct ?? '',
                    amount: double.tryParse(amountController.text) ?? 0,
                    totalCost: totalCost,
                    paidAmount: paidAmount,
                    unPaidAmount: unpaidAmount);
                context
                    .read<ProductsSalesBloc>()
                    .add(AddSalesEvent(productSale: productSale));
                if (state.addSalesStatus.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                      content: Text(
                        'Registered successfuly',
                        style: TextStyle(color: Colors.white),
                      )));
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
