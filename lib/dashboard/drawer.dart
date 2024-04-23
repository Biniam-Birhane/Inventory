import "package:flutter/material.dart";
import "package:simple_inventory/customers/presentation/pages/add_customer.dart";
import "package:simple_inventory/product_category/presentation/pages/product_category.dart";
import "package:simple_inventory/products/presentation/pages/products.dart";

Drawer DrawerPage(Size size, BuildContext context) {
  return Drawer(
    backgroundColor: Color(0xFF151D26),
    child: Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
         const Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 30.0, 30.0, 10.0),
              child: Row(
                children: [
                   CircleAvatar(
                    backgroundColor: Color(0xFF151D26),
                    foregroundImage: AssetImage('assets/images/logo.png'),
                    radius: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                   Text(
                    "Board Inventory",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Quicksand'),
                  ),
                ],
              )),
          const Divider(
            height: 10,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              child: Column(
                children: [
                  Container(
                    child: ListTile(
                      horizontalTitleGap: size.width * 0.04,
                      leading:
                          const Icon(Icons.shopping_cart, color: Colors.white),
                      title: const Text(
                        "Add Products",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Quicksand',
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Products()));
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    child: ListTile(
                      horizontalTitleGap: size.width * 0.04,
                      leading: const Icon(Icons.category, color: Colors.white),
                      title: const Text(
                        "Product Categories ",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Quicksand",
                          fontSize: 18,
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
                  Container(
                    child: ListTile(
                      horizontalTitleGap: size.width * 0.04,
                      leading: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Customers",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Quicksand",
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Customers()));
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  ListTile(
                    horizontalTitleGap: size.width * 0.04,
                    leading: const Icon(
                      Icons.payment,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Payment",
                      style: TextStyle(
                        color: Color.fromARGB(255, 243, 243, 243),
                        fontFamily: "Quicksand",
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
