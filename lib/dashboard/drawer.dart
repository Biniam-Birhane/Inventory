import "package:flutter/material.dart";
import "package:simple_inventory/customers/presentation/pages/add_customer.dart";
import "package:simple_inventory/product_category/presentation/pages/product_category.dart";

Drawer DrawerPage(Size size, BuildContext context) {
  return Drawer(
    backgroundColor: Color(0xFF151D26),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: ListTile(
                        horizontalTitleGap: size.width * 0.06,
                        leading: const Icon(Icons.shopping_cart,
                            color: Colors.white),
                        title: const Text(
                          "Add Products",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Quicksand",
                            fontSize: 15,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Divider(
                      height: 10,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      child: ListTile(
                        horizontalTitleGap: size.width * 0.06,
                        leading:
                            const Icon(Icons.category, color: Colors.white),
                        title: const Text(
                          "Add Product Category ",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Quicksand",
                            fontSize: 15,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductCategory()));
                        },
                      ),
                    ),
                    Divider(
                      height: 10,
                    ),
                    Container(
                      child: ListTile(
                        horizontalTitleGap: size.width * 0.06,
                        leading: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        title: const Text(
                          "Add Customer",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Quicksand",
                            fontSize: 15,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Customer()));
                        },
                      ),
                    ),
                    const Divider(
                      height: 10,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      child: ListTile(
                        horizontalTitleGap: size.width * 0.06,
                        leading: const Icon(
                          Icons.payment,
                          color: Colors.white,
                        ),
                        title: const Text(
                          "Payment",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Quicksand",
                            fontSize: 15,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Divider(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
