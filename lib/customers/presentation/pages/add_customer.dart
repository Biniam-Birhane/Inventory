import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/customers/domain/entities/customer_entity.dart';
import 'package:simple_inventory/customers/presentation/bloc/customers_bloc.dart';
import 'package:simple_inventory/customers/presentation/widgets/edit_customer.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});
  @override
  State<Customers> createState() => _CustomersScreen();
}

class _CustomersScreen extends State<Customers> with TickerProviderStateMixin {
  List<CustomerEntity> searchedCustomers = [];
  void getCustomers() {
    context.read<CustomersBloc>().add(GetCustomersEvent());
  }

  @override
  void initState() {
    super.initState();
    getCustomers();
  }

  void searchCustomers(String name, List<CustomerEntity> customers) {
    if (name.isEmpty) {
      setState(() {
        searchedCustomers = customers;
      });
    } else {
      final List<CustomerEntity> result = customers
          .where((customer) =>
              customer.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
      setState(() {
        searchedCustomers = result;
      });
    }
  }

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CustomersBloc, CustomersState>(
        listener: (context, state) {
      if (state.getCustomerStatus.isSuccess) {
        setState(() {
          searchedCustomers = state.customers;
        });
      }

      print(state.getCustomerStatus);
      if (state.addCustomerstatus.isSuccess ||
          state.updateCustomerstatus.isSuccess ||
          state.deleteCustomerStatus.isSuccess) {
        getCustomers();
      }
    }, builder: (context, state) {
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
              child: state.getCustomerStatus.isSuccess
                  ? Column(
                      children: [
                        searchBar(size, state),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: searchedCustomers.length,
                            itemBuilder: (context, index) {
                              final customer = searchedCustomers[index];
                              return Container(
                                child: ExpansionTile(
                                  iconColor: Colors.white,
                                  dense: false,
                                  leading: Container(
                                    width: size.width * 0.2,
                                    child: Text((1 + index).toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Quicksand",
                                            fontSize: 20)),
                                  ),
                                  title: Text(
                                    customer.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Quicksand",
                                        fontSize: 20),
                                  ),
                                  children: [
                                    Text(
                                      'phone: ${customer.phoneNumber}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Quicksand",
                                          fontSize: 16),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      EditCustomer(
                                                          customer: customer));
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.green,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              alertDelete(customer);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                      color: Colors.white,
                    ))),
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
    });
  }

  Row searchBar(Size size, CustomersState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: size.width * 0.75,
          child: TextField(
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  hintText: "Search customer",
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  hintStyle: const TextStyle(color: Colors.grey),
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
              onChanged: (value) {
                searchCustomers(value, state.customers);
              }),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              backgroundColor: const Color(0xFFFE8A00),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const Icon(
            Icons.search,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Material addCustomer() {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              color: Color(0xFF151D26),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: fullNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Enter Full Name",
                      labelText: "Name",
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
                        borderSide:
                            const BorderSide(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                        borderSide:
                            const BorderSide(color: Colors.green, width: 2),
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
        ),
      ),
    );
  }

  Future<dynamic> alertDelete(CustomerEntity customer) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm deletion"),
            content: Text(
              "Are you sure you want to delete ${customer.name}?",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  context
                      .read<CustomersBloc>()
                      .add(DeleteCustomerEvent(id: customer.id));
                  Navigator.pop(context);
                },
                child: const Text(
                  "Yes",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)))
            ],
          );
        });
  }

  BlocConsumer submitButton() {
    return BlocConsumer<CustomersBloc, CustomersState>(
        listener: (context, state) {
      print(state.addCustomerstatus);
    }, builder: (context, state) {
      return state.addCustomerstatus.isInProgress
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                context.read<CustomersBloc>().add(AddCustomerEvent(
                    name: fullNameController.text,
                    phoneNumber: phoneNumberController.text));
                if (state.addCustomerstatus.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                      content: Text(
                        "Added successfuly",
                        style: TextStyle(color: Colors.white),
                      )));
                  Navigator.of(context);
                } else if (state.addCustomerstatus.isFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.white),
                    ),
                    duration: const Duration(seconds: 5),
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFE8A00),
                  padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 10,
                    horizontal: 60,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
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
    });
  }
}
