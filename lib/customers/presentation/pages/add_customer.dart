import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_inventory/dashboard/drawer.dart';

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
          "customers",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: DrawerPage(size, context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: customers.length,
          itemBuilder: (context, index) {
            final customer = customers[index];
            return Container(
              height: 75,
              child: Card(
                color: const Color.fromARGB(255, 27, 63, 92),
                elevation: 9,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: ListTile(
                  dense: false,
                  leading: Text((1 + index).toString(),
                      style: const TextStyle(color: Colors.white)),
                  title: Text(
                    customer.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    customer.phoneNumber,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      )),

                  //  Row(children: [
                  //   // IconButton(onPressed: (){}, icon: const Icon(Icons.delete, color: Colors.red,))
                  // ],),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Container(
        color: const Color(0xFFFE8A00),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFE8A00)),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return addCustomer();
                });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
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
              decoration: const InputDecoration(
                  labelText: "Full Name",
                  hintText: "Enter Full Name",
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: phoneNumberController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: "Phone Number",
                  hintText: 'Enter phone number',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                  try {
                    print('right');
                    await firebaseAuth.createUserWithEmailAndPassword(
                        email: "bini@gmail.com", password: 'passpass');
                    print("added successfuly");
                  } catch (e) {
                    print(e.toString);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFE8A00)),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Quicksand",
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
