import 'package:flutter/material.dart';
import 'package:simple_inventory/dashboard/dashbord.dart';

bottomLogic(selectedIndex, context) {
  if (selectedIndex == 0) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Dashboard()));
    // } else if (selectedIndex == 1) {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => ShoeFavoritePage()));
    // } else if (selectedIndex == 2) {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => CartPage()));
    // } else if (selectedIndex == 3) {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => Profile()));
    // }
  }
}
