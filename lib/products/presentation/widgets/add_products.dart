
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/product_category/presentation/bloc/product_category_bloc.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products/presentation/bloc/products_bloc.dart';
import 'package:simple_inventory/products/presentation/pages/products.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key, required this.amount, required this.unitPrice})
      : super(key: key);

  final TextEditingController amount;
  final TextEditingController unitPrice;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? valueChoose;
  String? selectedProductId;
  List<String> listItem = [];
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productIdController = TextEditingController();
  var uuid = const Uuid();
  late  Map<String, String> productNameMap ={} ;

  @override
  void initState() {
    context.read<ProductCategoryBloc>().add(const GetProductCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF151D26),
      appBar: AppBar(
          backgroundColor: const Color(0xFF151D26),
          title: const Text(
            "Add Products",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Quicksand",
              fontSize: 20,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            BlocConsumer<ProductCategoryBloc, ProductCategoryState>(
              listener: (context, state) {
                if (state.getProductCategoryStatus.isSuccess) {
                  for (var i = 0; i < state.productCategories.length; i++) {
                    String productName = state.productCategories[i].productName;
                    String productId = state.productCategories[i].id;
                    listItem.add(productName);
                    // Store product id along with product name
                    productNameMap[productName] = productId;
                  }
                }
              },
              builder: (context, state) {
                return state.getProductCategoryStatus.isSuccess
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton(
                            hint: const Text(
                              "Select product :",
                              style: TextStyle(
                                fontFamily: "Quicksand",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 36,
                            dropdownColor: Colors.black,
                            isExpanded: true,
                            underline: const SizedBox(),
                            style: const TextStyle(
                              fontFamily: "Quicksand",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 228, 205, 205),
                            ),
                            value: valueChoose,
                            onChanged: (newValue) {
                              setState(() {
                                valueChoose = newValue;
                                // Update selected product id based on selected product name
                                selectedProductId = productNameMap[newValue];
                                print(selectedProductId);
                                // Set the selected product name to the controller
                                productNameController.text = newValue!;
                                // Set the selected product id to the controller
                                productIdController.text = selectedProductId!;
                              });
                            },
                            items: listItem.map((valueItem) {
                              return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(
                                    valueItem,
                                    style: TextStyle(color: Colors.white),
                                  ));
                            }).toList()),
                      )
                    : const CircularProgressIndicator();
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            productNameField(widget.amount, "Enter Amount", "Amount"),
            SizedBox(
              height: size.height * 0.03,
            ),
            productNameField(
                widget.unitPrice, "Enter Unit Price", "Unit Price"),
            SizedBox(
              height: size.height * 0.03,
            ),
            submitButton(context)
          ],
        ),
      ),
    );
  }

  TextFormField productNameField(controllerName, hintText, labelText) {
    return TextFormField(
      controller: controllerName,
      style: const TextStyle(
        fontFamily: "Quicksand",
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: const TextStyle(color: Colors.grey),
        labelStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          print("please enter value");
          return 'Please enter value';
        }
        return null;
      },
    );
  }

  BlocConsumer submitButton(context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state.addProductStatus.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              content: Text(
                "Added successfuly",
                style: TextStyle(color: Colors.white),
              )));
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Products()));
        } else if (state.addProductStatus.isFailure) {
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
      builder: (context, state) {
        return state.addProductStatus.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  String id = uuid.v4();
                  String? productName = valueChoose ?? '';
                  String? productId = selectedProductId;
                  double amount = double.tryParse(widget.amount.text) ?? 0.0;
                  double unitPrice =
                      double.tryParse(widget.unitPrice.text) ?? 0.0;

                  if (amount != null &&
                      unitPrice != null &&
                      productName != null &&
                      productId != null) {
                    DateTime dateTime = DateTime.now();
                    ProductEntity product = ProductEntity(
                        id: id,
                        productId: productId,
                        productName: productName,
                        unitPrice: unitPrice,
                        amount: amount,
                        date: dateTime.day,
                        month: dateTime.month,
                        year: dateTime.year,
                        createdAt: dateTime);

                    context
                        .read<ProductsBloc>()
                        .add(AddProductEvent(product: product));
                  } else {
                    // Handle invalid data scenario, maybe show a message to the user
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Invalid data entered!",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
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
      },
    );
  }
}
