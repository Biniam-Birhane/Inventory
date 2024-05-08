import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/customers/domain/entities/customer_entity.dart';
import 'package:simple_inventory/customers/presentation/bloc/customers_bloc.dart';

class UnpaidAmountData {
  final double amount;
  final String createdAt;

  UnpaidAmountData(this.amount, this.createdAt);
}

class UnpaidAmount extends StatefulWidget {
  const UnpaidAmount({Key? key}) : super(key: key);

  @override
  State<UnpaidAmount> createState() => _UnpaidAmountState();
}

class _UnpaidAmountState extends State<UnpaidAmount> {
  @override
  void initState() {
    context.read<CustomersBloc>().add(GetCustomersEvent());
    super.initState();
  }

  List<CustomerEntity> customers = [];
  Map<String, List<UnpaidAmountData>> unpaidAmountsMap = {};
  CollectionReference sales = FirebaseFirestore.instance.collection('sales');

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151D26),
      appBar: AppBar(
        backgroundColor: const Color(0xFF151D26),
        title: const Text(
          "Unpaid Amount",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Quicksand",
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<CustomersBloc, CustomersState>(
        listener: (context, state) {
          if (state.getCustomerStatus.isSuccess) {
            customers = state.customers;
            for (var customer in customers) {
              getUnpaidAmounts(customer.name, customer.id);
            }
          }
        },
        builder: (context, state) {
          if (state.getCustomerStatus.isInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.getCustomerStatus.isFailure) {
            return const Center(
              child: Text("Failed to load data"),
            );
          } else {
            return ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customerName = customers[index].name;
                final customerId = customers[index].id;
                final unpaidAmounts = unpaidAmountsMap[customerId] ?? [];

                final totalUnpaidAmount = unpaidAmounts.isNotEmpty
                    ? unpaidAmounts
                        .map((amountData) => amountData.amount)
                        .reduce((value, element) => value + element)
                    : 0;

                // Check if total unpaid amount is greater than 0, if not, return a SizedBox to skip displaying the customer
                if (totalUnpaidAmount == 0) {
                  return const SizedBox.shrink();
                }
                return ExpansionTile(
                  iconColor: Colors.white,
                  leading: Container(
                    width: 180,
                    child: Text(
                      customerName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Quicksand",
                        fontSize: 20,
                      ),
                    ),
                  ),
                  title: unpaidAmounts.isEmpty
                      ? const Text(
                          'Loading...',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Quicksand",
                          ),
                        )
                      : Text(
                          '${unpaidAmounts.map((amountData) => amountData.amount.toDouble()).reduce((value, element) => value + element)}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontFamily: "Quicksand",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: unpaidAmounts.length,
                      itemBuilder: (context, index) {
                        final amountData = unpaidAmounts[index];
                        return ListTile(
                          leading: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Quicksand",
                              fontSize: 16,
                            ),
                          ),
                          title: Text(
                            'Amount: ${amountData.amount}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontFamily: "Quicksand",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Text(
                            'Date: ${amountData.createdAt}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Quicksand",
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> getUnpaidAmounts(String customerName, String customerId) async {
    List<UnpaidAmountData> unpaidAmounts = [];

    // Perform a query for unpaid amounts corresponding to the customer's name
    QuerySnapshot querySnapshot =
        await sales.where('buyerName', isEqualTo: customerName).get();

    // Extract unpaid amounts and creation dates
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      final double amount = doc['unPaidAmount'];
      final Timestamp timestamp = doc['createdAt'];
      final DateTime createdAt = timestamp.toDate();
      final formattedDate = DateFormat('yyyy-MM-dd').format(createdAt);

      unpaidAmounts.add(UnpaidAmountData(amount, formattedDate));
    }

    setState(() {
      unpaidAmountsMap[customerId] = unpaidAmounts;
    });
  }
}
