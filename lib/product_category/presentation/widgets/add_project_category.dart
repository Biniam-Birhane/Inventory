import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProductCategory extends StatelessWidget {
  const AddProductCategory({required this.productName, super.key});
  final TextEditingController productName;
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
                        fontSize: 20,fontWeight: FontWeight.bold),
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

  ElevatedButton submitButton(context) {
    return ElevatedButton(
      onPressed: () => {Navigator.of(context).pop()},
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFE8A00),
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: 10,
            horizontal: 60,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
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
  }

  TextFormField productNameField() {
    return TextFormField(
      controller: productName,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: "Enter Product Name",
          labelText: "Name",
          hintStyle: TextStyle(color: Colors.grey),
          labelStyle: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
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
