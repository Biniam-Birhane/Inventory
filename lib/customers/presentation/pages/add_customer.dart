import 'package:flutter/material.dart';

class CustomerModel {
  CustomerModel({required this.name, required this.phoneNumber});
  final String name;
  final String phoneNumber;
}

class Customer extends StatelessWidget {
  Customer({super.key});
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final List<CustomerModel> customers = [
    CustomerModel(name: 'kibrom', phoneNumber: '0987654321'),
    CustomerModel(name: 'bil', phoneNumber: '089765'),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xFF151D26),
        appBar: AppBar(
          backgroundColor: const Color(0xFF151D26),
          title: const Text(
            "Customers",
            style: TextStyle(
                color: Colors.white, fontFamily: "Quicksand", fontSize: 20),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];
              return Container(
                child: ListTile(
                  dense: false,
                  leading: Text((1 + index).toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Quicksand",
                          fontSize: 20)),
                  title: Text(
                    customer.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Quicksand",
                        fontSize: 20),
                  ),
                  subtitle: Text(
                    customer.phoneNumber,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Quicksand",
                        fontSize: 20),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  ),

                  //  Row(children: [
                  //   // IconButton(onPressed: (){}, icon: const Icon(Icons.delete, color: Colors.red,))
                  // ],),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            showDialog(context: context, builder: (context) => addCustomer())
          },
          backgroundColor: const Color(0xFFFE8A00),
          elevation: 20,
          child: const Icon(
            Icons.add,
          ),
        ));
  }

  Material addCustomer() {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        // color: Colors.white,
        // height: 300,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: fullNameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: "Enter Full Name",
                  labelText: "Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: phoneNumberController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: "Enter Mobile Number",
                  labelText: "Phone Number",
                  hintStyle: const TextStyle(color: Colors.grey),
                  labelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always),
            ),
            const SizedBox(
              height: 20,
            ),
            submitButton()
          ],
        ),
      ),
    );
  }

  ElevatedButton submitButton() {
    return ElevatedButton(
      onPressed: () => {},
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFE8A00),
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: 10,
            horizontal: 60,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: const Text(
        "Submit",
        style: TextStyle(
          fontFamily: "Quicksand",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
