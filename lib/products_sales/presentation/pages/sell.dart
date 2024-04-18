import 'package:flutter/material.dart';
import 'package:simple_inventory/products_sales/presentation/widgets/dropdown_button.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151D26),
      appBar: AppBar(
        title: const Text(
          'sell product',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFF151D26),
          child: Column(
            children: [
              MyDropdownButton(),
              const Text(
                "Dropdown",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
