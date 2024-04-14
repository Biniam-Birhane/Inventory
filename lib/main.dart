import 'package:flutter/material.dart';
import 'package:simple_inventory/product_category/presentation/pages/product_category.dart';
import './dashboard/dashbord.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        primaryColor: Colors.red,
        useMaterial3: true,
      ),
      
      home: Dashboard(),
    );
  }
}
