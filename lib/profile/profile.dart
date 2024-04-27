import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_inventory/bottomPage/bottom_items_list.dart';
import 'package:simple_inventory/bottomPage/bottom_logic.dart';
import 'package:simple_inventory/bottomPage/common_bottom_bar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selectedIndex = 2;
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
        title: Text("Profile",
            style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.white,
                fontSize: size.width * 0.05)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            backgroundImage(size),
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // color: Colors.grey,
                child: ListTile(
                  horizontalTitleGap: 30,
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(
                    "Add User",
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.white,
                        fontSize: size.width * 0.05),
                  ),
                  trailing: Icon(
                    Icons.forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // color: Colors.grey,
                child: ListTile(
                  horizontalTitleGap: 30,
                  leading: const CircleAvatar(
                    child: Icon(Icons.local_activity),
                  ),
                  title: Text(
                    "Recent activities",
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.white,
                        fontSize: size.width * 0.05),
                  ),
                  trailing: Icon(
                    Icons.local_activity,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // color: Colors.grey,
                child: ListTile(
                  horizontalTitleGap: 30,
                  leading: const CircleAvatar(
                    child: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.red,
                        fontSize: size.width * 0.05),
                  ),
                  trailing: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CommonBottomBar(
          items: bottomBarItems,
          currentIndex: selectedIndex,
          onTap: _onItemTapped),
    );
  }

  Stack backgroundImage(Size size) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/background.jpg',
          width: size.width,
          height: size.height * 0.25,
          fit: BoxFit.cover,
        ),
        const Positioned(
          bottom: 10,
          left: 20,
          child: CircleAvatar(
            foregroundImage: AssetImage('assets/images/logo.png'),
            radius: 40,
          ),
        ),
        Positioned(
            width: size.width * 0.7,
            bottom: 10,
            left: 100,
            child: ListTile(
              title: Text(
                "Board Inventory",
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.white,
                    fontSize: size.width * 0.05),
              ),
              subtitle: Text(
                "Manager",
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.white,
                    fontSize: size.width * 0.05),
              ),
              trailing: IconButton(
                  onPressed: () {}, color: Colors.grey, icon: Icon(Icons.edit)),
            ))
      ],
    );
  }
}
