import 'package:flutter/material.dart';
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
  void getCustomers() {
    context.read<CustomersBloc>().add(GetCustomersEvent());
  }

  @override
  void initState() {
    super.initState();
    getCustomers();
  }

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomersBloc, CustomersState>(
        listener: (context, state) {
      print(state.getCustomerStatus);
      if (state.addCustomerstatus.isSuccess ||
          state.updateCustomerstatus.isSuccess ||
          state.deleteCustomerStatus.isSuccess) {
        getCustomers();
      }
    }, builder: (context, state) {
      return Scaffold(
          backgroundColor: const Color.fromARGB(255, 86, 111, 140),
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
                  ? ListView.builder(
                      itemCount: state.customers.length,
                      itemBuilder: (context, index) {
                        final customer = state.customers[index];
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
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              EditCustomer(customer: customer));
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

                            //  Row(children: [
                            //   // IconButton(onPressed: (){}, icon: const Icon(Icons.delete, color: Colors.red,))
                            // ],),
                          ),
                        );
                      },
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

  Material addCustomer() {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              color: Colors.black,
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
              "Are you sure to delete ${customer.name}",
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
                      color: Colors.blue,
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
                } else if (state.addCustomerstatus.isFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
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
