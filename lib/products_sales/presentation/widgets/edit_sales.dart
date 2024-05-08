import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/customers/presentation/bloc/customers_bloc.dart';
import 'package:simple_inventory/product_category/presentation/bloc/product_category_bloc.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/products_sales/presentation/bloc/products_sales_bloc.dart';
import 'package:simple_inventory/products_sales/presentation/pages/product_sales.dart';

class EditSales extends StatefulWidget {
  @override
  const EditSales({required this.soldProduct, super.key});
  final ProductSale soldProduct;
  @override
  State<EditSales> createState() => _UpdateSaleState();
}

class _UpdateSaleState extends State<EditSales> {
  TextEditingController amountController = TextEditingController();
  TextEditingController totalCostController = TextEditingController();
  TextEditingController paidAmountController = TextEditingController();
  String? selectedProduct;
  String? selectedProductId;
  List<String> products = [];
  String? id;
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
    id = widget.soldProduct.id;
    selectedCustomer = widget.soldProduct.buyerName;
    selectedProduct = widget.soldProduct.productName;
    selectedProductId = widget.soldProduct.productId;
    amountController.text = widget.soldProduct.amount.toString();
    totalCostController.text = widget.soldProduct.totalCost.toString();
    paidAmountController.text = widget.soldProduct.paidAmount.toString();
    // Size size = MediaQuery.of(context).size;
    super.initState();
    getCustomers();
    getProductCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151D26),
      appBar: AppBar(
          backgroundColor: const Color(0xFF151D26),
          title: const Text(
            "Update product sales",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Quicksand",
              fontSize: 20,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              BlocConsumer<ProductCategoryBloc, ProductCategoryState>(
                buildWhen: (previous, current) {
                  return previous.getProductCategoryStatus !=
                      current.getProductCategoryStatus;
                },
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
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton(
                              dropdownColor:
                                  const Color.fromARGB(255, 41, 71, 95),
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36,
                              isExpanded: true,
                              underline: SizedBox(),
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
                              border: Border.all(color: Colors.grey, width: 1),
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
                                  print(newValue);
                                  selectedCustomer = newValue;
                                });
                              },
                              items: customers.map((customer) {
                                return DropdownMenuItem(
                                    value: customer,
                                    child: Text(
                                      customer,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ));
                              }).toList()),
                        )
                      : const CircularProgressIndicator();
                },
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
                    labelText: "Amount",
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
                    hintText: "Total cost ",
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
                    hintText: "Paid amount in Birr",
                    labelText: "Paid Amount",
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
              submitButton()
            ],
          ),
        ),
      ),
    );
  }

  BlocConsumer submitButton() {
    return BlocConsumer<ProductsSalesBloc, ProductsSalesState>(
        listener: (context, state) {
      print(state.updateSalesStatus);
      if (state.updateSalesStatus.isSuccess) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ProductSales()));
      }
    }, builder: (context, state) {
      return state.updateSalesStatus.isInProgress
          ? const CircularProgressIndicator(color: Colors.white)
          : ElevatedButton(
              onPressed: () {
                print(selectedCustomer);
                double amount = double.tryParse(amountController.text) ?? 0;
                double totalCost =
                    double.tryParse(totalCostController.text) ?? 0;
                double paidAmount =
                    double.tryParse(paidAmountController.text) ?? 0;
                double unPaidAmount = totalCost - paidAmount;
                final ProductSale productSale = ProductSale(
                    id: id ?? '',
                    buyerName: selectedCustomer ?? '',
                    productName: selectedProduct ?? '',
                    productId: selectedProductId ?? '',
                    amount: amount,
                    totalCost: totalCost,
                    paidAmount: paidAmount,
                    unPaidAmount: unPaidAmount);
                context
                    .read<ProductsSalesBloc>()
                    .add(UpdateSaleEvent(productSale: productSale));
                if (state.updateSalesStatus.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                      content: Text(
                        "Added successfuly",
                        style: TextStyle(color: Colors.white),
                      )));
                } else if (state.updateSalesStatus.isFailure) {
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
