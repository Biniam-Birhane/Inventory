import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_inventory/product_category/presentation/widgets/add_project_category.dart';

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
              "List of Product Categories",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Quicksand",
                  fontSize: 20,
                  ),
            ),
            iconTheme: IconThemeData(color: Colors.white)),
        body: Column(children: [
          // const Center(
          //   child: Text(
          //     "List of Product Categories",
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontFamily: "Quicksand",
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold),
          //   ),
          // ),
          listOfCategories("30X60", "Photo Board", size),
          listOfCategories("50X70", "Photo Board", size),
          listOfCategories("20X80", "Photo Board", size),
          listOfCategories("60X80", "Photo Board", size),
          listOfCategories("70X90", "Photo Board", size),
          listOfCategories("10X30", "Photo Board", size),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            showDialog(
                context: context,
                builder: (context) =>
                    AddProductCategory(productName: _productName))
          },
          backgroundColor: Color(0xFFFE8A00),
          elevation: 20,
          child: const Icon(
            Icons.add,
          ),
        ));
  }

  ListTile listOfCategories(String name, String description, Size size) {
    return ListTile(
      leading: Container(
        width: size.width * 0.2,
        child: Text(name,
            style: const TextStyle(
                color: Colors.white, fontFamily: "Quicksand", fontSize: 20)),
      ),
      title: Text(description,
          style: const TextStyle(
              color: Colors.white, fontFamily: "Quicksand", fontSize: 20)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () => {}, color: Colors.green, icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () => {}, color: Colors.red, icon: Icon(Icons.delete))
        ],
      ),
    );
  }
}
