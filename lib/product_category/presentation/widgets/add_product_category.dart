import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/product_category/presentation/bloc/product_category_bloc.dart';
import 'package:simple_inventory/product_category/presentation/pages/product_category.dart';
import 'package:uuid/uuid.dart';

class AddProductCategory extends StatelessWidget {
  AddProductCategory({required this.productName, super.key});
  final TextEditingController productName;
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Form(
                  child: Column(
                children: [
                  Container(
                      child: const Text(
                    "Add Product Category",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Quicksand",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  productNameField(),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  submitButton(context),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }

  BlocConsumer submitButton(context) {
    return BlocConsumer<ProductCategoryBloc, ProductCategoryState>(
      listener: (context, state) {
        if (state.addProductCategoryStatus.isSuccess) {
          productName.text = '';
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              content: Text(
                "Added successfuly",
                style: TextStyle(color: Colors.white),
              )));

          
        } else if (state.addProductCategoryStatus.isFailure) {
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
        return state.addProductCategoryStatus.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  String id = uuid.v4();
                  double availableAmount = 0.0;
                  context.read<ProductCategoryBloc>().add(
                      AddProductCategoryEvent(
                          id: id,
                          productName: productName.text,
                          availableAmount: availableAmount));
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

  TextFormField productNameField() {
    return TextFormField(
      controller: productName,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: "Enter Product Name",
          labelText: "Name",
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
          floatingLabelBehavior: FloatingLabelBehavior.always),
    );
  }
}
