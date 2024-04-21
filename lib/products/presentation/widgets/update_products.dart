import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/product_category/presentation/bloc/product_category_bloc.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products/presentation/bloc/products_bloc.dart';
import 'package:simple_inventory/products/presentation/pages/products.dart';
import 'package:uuid/uuid.dart';

class UpdateProduct extends StatefulWidget {
  @override
  const UpdateProduct({
    required this.id,
    required this.productId,
    required this.productName,
    required this.amount,
    required this.unitPrice,
  });
  final String id;
  final String productId;
  final String productName;
  final double amount;
  final double unitPrice;

  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  TextEditingController amountController = TextEditingController();
  TextEditingController unitPriceController = TextEditingController();
  String? valueChoose;
  List<String> listItem = [];

  @override
  void initState() {
    amountController.text = widget.amount.toString();
    unitPriceController.text = widget.unitPrice.toString();
    valueChoose = widget.productName;
    // listItem.clear();
    context.read<ProductCategoryBloc>().add(GetProductCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF151D26),
          title: const Text(
            "Update Products",
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
              buildWhen: (previous, current) {
                return previous.getProductCategoryStatus !=
                    current.getProductCategoryStatus;
              },
              listener: (context, state) {
                if (state.getProductCategoryStatus.isSuccess) {
                  for (var i = 0; i < state.productCategories.length; i++) {
                    String productName = state.productCategories[i].productName;

                    listItem.add(productName);
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
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 36,
                            isExpanded: true,
                            underline: SizedBox(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            value: valueChoose,
                            onChanged: (newValue) {
                              setState(() {
                                valueChoose = newValue;
                              });
                            },
                            items: listItem.map((valueItem) {
                              return DropdownMenuItem(
                                  value: valueItem, child: Text(valueItem));
                            }).toList()),
                      )
                    : const CircularProgressIndicator();
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            productNameField(amountController, "Enter Amount", "Amount"),
            SizedBox(
              height: size.height * 0.03,
            ),
            productNameField(
                unitPriceController, "Enter Unit Price", "Unit Price"),
            SizedBox(
              height: size.height * 0.03,
            ),
            submitButton(context)
          ],
        ),
      ),
    );
  }

  TextFormField productNameField(
      TextEditingController controllerName, hintText, labelText) {
    return TextFormField(
      controller: controllerName,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          hintStyle: const TextStyle(color: Colors.grey),
          labelStyle: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
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
    );
  }

  BlocConsumer submitButton(context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state.updateProductStatus.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              content: Text(
                "Updated successfuly",
                style: TextStyle(color: Colors.white),
              )));
          listItem.clear();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Products()));
        } else if (state.updateProductStatus.isFailure) {
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
        return state.updateProductStatus.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  String id = widget.id;
                  String? productName = valueChoose ?? '';
                  double amount = double.parse(amountController.text);
                  double unitPrice = double.parse(unitPriceController.text);

                  if (amount != null &&
                      unitPrice != null &&
                      productName != null) {
                    ProductEntity product = ProductEntity(
                      id: id,
                      productId: id,
                      productName: productName,
                      unitPrice: unitPrice,
                      amount: amount,
                    );
                    print(product);
                    context
                        .read<ProductsBloc>()
                        .add(UpdateProductEvent(product: product));
                  } else {
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
                  "Update",
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
