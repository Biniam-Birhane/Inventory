import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_inventory/bottomPage/bottom_items_list.dart';
import 'package:simple_inventory/bottomPage/bottom_logic.dart';
import 'package:simple_inventory/bottomPage/common_bottom_bar.dart';
import 'package:simple_inventory/dashboard/drawer.dart';

class Dashboard extends StatefulWidget {
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    bottomLogic(selectedIndex, context);
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF151D26),
      appBar: AppBar(
        backgroundColor: Color(0xFF151D26),
        title: Row(
          children: [
            SizedBox(width: size.width * 0.08),
            const Text(
              "Board Inventory",
              style: TextStyle(fontFamily: 'Lato-Black', color: Colors.white),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/logo.png',
            height: size.height * 0.05,
            width: size.height * 0.05,
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
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
              totalProduct(size, "Total Unpaid Amount", 8523)
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
        onTap: () => {},
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            height: size.height * 0.15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromARGB(255, 27, 63, 92)),
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
                          color: Colors.white, fontSize: size.height * 0.04),
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
            onPressed: () => {},
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFE8A00),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.black,
                  size: size.width * 0.05,
                ),
                Text(
                  "Sell Product",
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
