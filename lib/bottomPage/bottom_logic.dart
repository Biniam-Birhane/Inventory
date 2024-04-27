import 'package:flutter/material.dart';
import 'package:simple_inventory/dashboard/dashbord.dart';
import 'package:simple_inventory/profile/profile.dart';
import 'package:simple_inventory/reports/presentation/pages/report.dart';

bottomLogic(selectedIndex, context) {
  if (selectedIndex == 0) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Dashboard()));
  } else if (selectedIndex == 1) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const ReportPage()));
  } else if (selectedIndex == 2) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Profile()));
  }
  // } else if (selectedIndex == 3) {
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => Profile()));
  // }
}
