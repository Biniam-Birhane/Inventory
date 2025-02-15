import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_inventory/bottomPage/bottom_items_list.dart';
import 'package:simple_inventory/bottomPage/bottom_logic.dart';
import 'package:simple_inventory/bottomPage/common_bottom_bar.dart';
import 'package:simple_inventory/dashboard/drawer.dart';
import 'package:simple_inventory/dashboard/totalProduct/total_product.dart';
import 'package:simple_inventory/dashboard/unpaid_amount.dart';
import 'package:simple_inventory/products_sales/presentation/pages/product_sales.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  int selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    bottomLogic(selectedIndex, context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF151D26),
      appBar: AppBar(
        backgroundColor: const Color(0xFF151D26),
        title: Row(
          children: [
            Text(
              "Board Inventory",
              style: TextStyle(
                  fontFamily: 'Lato-Black',
                  color: Colors.white,
                  fontSize: size.width * 0.06),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/logo.png',
            height: size.width * 0.1,
            width: size.width * 0.1,
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: DrawerPage(size, context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              sellProduct(size),
              SizedBox(
                height: size.height * 0.02,
              ),
              totalProduct(size, "Total Product", 300),
              unPaidAmount(size, "Total Unpaid Amount", 8523)
            ],
          ),
        ),
      ),
      bottomNavigationBar: CommonBottomBar(
        items: bottomBarItems,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Padding totalProduct(Size size, String category, int amount) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TotalProduct()))
        },
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromARGB(255, 27, 63, 92)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.grey,
                          size: size.width * 0.06,
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Text(
                          category,
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Quicksand",
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Text(
                      amount.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white, fontSize: size.width * 0.06),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Padding unPaidAmount(Size size, String category, int amount) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>const UnpaidAmount()))
        },
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromARGB(255, 27, 63, 92)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.grey,
                          size: size.width * 0.06,
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Text(
                          category,
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Quicksand",
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Text(
                      amount.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white, fontSize: size.width * 0.06),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Row sellProduct(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Stores",
            style: TextStyle(
                fontFamily: 'Lato-Black',
                fontSize: size.width * 0.06,
                color: Colors.white)),
        ElevatedButton(
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductSales()))
                },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFE8A00),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
            child: Row(
              children: [
                Icon(
                  Icons.sell,
                  color: Colors.black,
                  size: size.width * 0.05,
                ),
                const SizedBox(width: 2),
                Text(
                  "Product Sales",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
