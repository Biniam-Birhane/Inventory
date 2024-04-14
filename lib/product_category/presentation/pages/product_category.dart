import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductCategory extends StatelessWidget {
  ProductCategory({super.key});
  TextEditingController _productName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF151D26),
      appBar: AppBar(
          backgroundColor: Color(0xFF151D26),
          title: const Text(
            "Add Product Category",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
              child: Column(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Add Product Category",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Quicksand",
                        fontSize: 20),
                  )),
              SizedBox(
                height: size.height * 0.03,
              ),
              productNameField(),
              SizedBox(
                height: size.height * 0.03,
              ),
              submitButton(),
              
            ],
          )),
        ),
      ),
    );
  }

  ElevatedButton submitButton() {
    return ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFE8A00),
                  padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 10,
                    horizontal: 60,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
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
              controller: _productName,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: "Enter Product Name",
                  labelText: "Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.white, fontSize: 18),
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
            );
  }
}
