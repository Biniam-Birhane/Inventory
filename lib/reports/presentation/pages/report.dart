import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:async';
import 'package:simple_inventory/bottomPage/bottom_items_list.dart';
import 'package:simple_inventory/bottomPage/bottom_logic.dart';
import 'package:simple_inventory/bottomPage/common_bottom_bar.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/reports/presentation/bloc/reports_bloc.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportScreen();
}

class _ReportScreen extends State<ReportPage> {
  int? selectedDate;
  int? selectedMonth;
  int? selectedYear;
  String? reportType;
  String? _selectedOption;
  int selectedIndex = 1;
  List<int> years = [2023, 2024];
  List<int> months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  List<int> days = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31
  ];
  final DateTime currentDate = DateTime.now();

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    bottomLogic(selectedIndex, context);
  }

  @override
  void initState() {
    super.initState();
    reportType = 'Daily';
    _selectedOption = 'sales';

    // selectedDate = int.tryParse(currentDate.day.toString());
    // selectedMonth = int.tryParse(currentDate.month.toString());
    // selectedYear = int.tryParse(currentDate.year.toString());
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF151D26),
      appBar: AppBar(
        backgroundColor: const Color(0xFF151D26),
        title: const Text(
          'Reports',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Quicksand",
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: CommonBottomBar(
        items: bottomBarItems,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  dropdownColor: const Color.fromARGB(255, 49, 72, 101),
                  hint: const Text("Collection:",
                      style: TextStyle(color: Colors.white)),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 36,
                  isExpanded: true,
                  underline: const SizedBox(),
                  style: const TextStyle(color: Colors.white10, fontSize: 18),
                  value: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                        value: 'sales',
                        child: Text(
                          'Sales',
                          style: TextStyle(color: Colors.white),
                        )),
                    DropdownMenuItem(
                        value: 'products',
                        child: Text(
                          'products',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              )),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                    dropdownColor: const Color.fromARGB(255, 49, 72, 101),
                    hint: const Text("Report Type :",
                        style: TextStyle(color: Colors.white)),
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    underline: const SizedBox(),
                    style: const TextStyle(color: Colors.white10, fontSize: 18),
                    value: reportType,
                    onChanged: (value) {
                      setState(() {
                        reportType = value;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                          value: 'Today',
                          child: Text(
                            'Today',
                            style: TextStyle(color: Colors.white),
                          )),
                      DropdownMenuItem(
                          value: 'thisMonth',
                          child: Text(
                            'This month',
                            style: TextStyle(color: Colors.white),
                          )),
                      DropdownMenuItem(
                          value: 'thisYear',
                          child: Text(
                            'This year',
                            style: TextStyle(color: Colors.white),
                          )),
                      DropdownMenuItem(
                          value: 'Daily',
                          child: Text(
                            'Daily',
                            style: TextStyle(color: Colors.white),
                          )),
                      DropdownMenuItem(
                          value: 'Monthly',
                          child: Text(
                            'Monthly',
                            style: TextStyle(color: Colors.white),
                          )),
                      DropdownMenuItem(
                          value: 'Yearly',
                          child: Text(
                            'Yearly',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ),
              )
            ]),
            _selectedOption == 'sales'
                ? Container(
                    height: 300,
                    child: Column(
                      children: [
                        reportType == 'Daily'
                            ? dailyReportFormat()
                            : reportType == 'Monthly'
                                ? monthlyReportFormat()
                                : reportType == 'Yearly'
                                    ? yearlyReportFormat()
                                    : reportType == 'Today' ||
                                            reportType == "thisMonth" ||
                                            reportType == "thisYear"
                                        ? const SizedBox()
                                        : const Center(
                                            child: Text(
                                              'please chose how do you want the reports to display',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                        BlocConsumer<ReportsBloc, ReportsState>(
                          listener: (context, state) {
                            print(state.gettingReportStatus);
                            print(state.errorMessage);
                          },
                          builder: ((context, state) {
                            return state.gettingReportStatus.isSuccess
                                ? Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state.salesReport.length,
                                        itemBuilder: ((context, index) {
                                          final ProductSale productSale =
                                              state.salesReport[index];
                                          return ExpansionTile(
                                              leading: Text(
                                                index.toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              title: Text(
                                                productSale.buyerName,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              children: [
                                                Text(
                                                  '${productSale.createdAt}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      'Item type: ${productSale.productName}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      'Amount: ${productSale.amount}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                                const Text(
                                                  'Payment status',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                ListTile(
                                                  leading: Text(
                                                    'total cost: ${productSale.totalCost}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  title: Text(
                                                    'paid amount: ${productSale.paidAmount}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  trailing: Text(
                                                    'unpaid amount: ${productSale.unPaidAmount}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ]);
                                        })),
                                  )
                                : state.gettingReportStatus.isInProgress
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ))
                                    : const SizedBox(
                                        height: 20,
                                      );
                          }),
                        ),
                      ],
                    ),
                  )
                : _selectedOption == "products"
                    ? Container(
                        height: 300,
                        child: Column(
                          children: [
                            reportType == 'Daily'
                                ? dailyReportFormat()
                                : reportType == 'Monthly'
                                    ? monthlyReportFormat()
                                    : reportType == 'Yearly'
                                        ? yearlyReportFormat()
                                        : reportType == 'Today' ||
                                                reportType == "thisMonth" ||
                                                reportType == "thisYear"
                                            ? const SizedBox()
                                            : const Center(
                                                child: Text(
                                                  'please chose how do you want the reports to display',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                            BlocConsumer<ReportsBloc, ReportsState>(
                              listener: (context, state) {
                                print(state.gettingProductReportStatus);
                                print(state.errorMessage);
                              },
                              builder: ((context, state) {
                                return state
                                        .gettingProductReportStatus.isSuccess
                                    ? Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                state.productsReport.length,
                                            itemBuilder: ((context, index) {
                                              final ProductEntity product =
                                                  state.productsReport[index];
                                              return ExpansionTile(
                                                  leading: Text(
                                                    (1 + index).toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  title: Text(
                                                    product.productName,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  children: [
                                                    Text(
                                                      '${product.amount}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          'Amount: ${product.unitPrice}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        )
                                                      ],
                                                    ),
                                                    const Text(
                                                      'Payment status',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                        'total cost: ${product.amount * product.unitPrice}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )
                                                  ]);
                                            })),
                                      )
                                    : state.gettingReportStatus.isInProgress
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ))
                                        : const SizedBox(
                                            height: 20,
                                          );
                              }),
                            ),
                          ],
                        ),
                      )
                    : const Center(
                        child: Text(
                          'choose collection',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
            BlocConsumer<ReportsBloc, ReportsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_selectedOption == 'sales') {
                        if (reportType == 'Monthly' &&
                            selectedMonth != null &&
                            selectedYear != null) {
                          context.read<ReportsBloc>().add(
                              GetMonthlyReportsEvent(
                                  month: selectedMonth ?? 10,
                                  year: selectedYear ?? 2024));
                        } else if (reportType == 'Yearly' &&
                            selectedYear != null) {
                          context.read<ReportsBloc>().add(GetYearlyReportsEvent(
                              year: selectedYear ?? 2024));
                        } else if (reportType == 'Daily' &&
                            selectedMonth != null &&
                            selectedYear != null &&
                            selectedDate != null) {
                          context.read<ReportsBloc>().add(GetDailyReportsEvent(
                              date: selectedDate ?? 1,
                              month: selectedMonth ?? 12,
                              year: selectedYear ?? 2024));
                        } else if (reportType == "Today") {
                          final DateTime today = DateTime.now();
                          context.read<ReportsBloc>().add(GetDailyReportsEvent(
                              date: today.day,
                              month: today.month,
                              year: today.year));
                        } else if (reportType == 'thisMonth') {
                          final DateTime currentDate = DateTime.now();
                          context.read<ReportsBloc>().add(
                              GetMonthlyReportsEvent(
                                  month: currentDate.month,
                                  year: currentDate.year));
                        } else if (reportType == 'thisYear') {
                          final DateTime currentDate = DateTime.now();
                          context.read<ReportsBloc>().add(
                              GetYearlyReportsEvent(year: currentDate.year));
                        } else if (reportType == '' || selectedYear == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'please choose the correct report format',
                                    style: TextStyle(color: Colors.white),
                                  )));
                        }
                      } else {
                        if (reportType == 'Monthly' &&
                            selectedMonth != null &&
                            selectedYear != null) {
                          context.read<ReportsBloc>().add(
                              GetMonthlyProductReportsEvent(
                                  month: selectedMonth ?? 10,
                                  year: selectedYear ?? 2024));
                        } else if (reportType == "Today") {
                          final DateTime today = DateTime.now();
                          context.read<ReportsBloc>().add(
                              GetDailyProductReportsEvent(
                                  date: today.day,
                                  month: today.month,
                                  year: today.year));
                        } else if (reportType == 'thisMonth') {
                          final DateTime currentDate = DateTime.now();
                          context.read<ReportsBloc>().add(
                              GetMonthlyProductReportsEvent(
                                  month: currentDate.month,
                                  year: currentDate.year));
                        } else if (reportType == 'thisYear') {
                          final DateTime currentDate = DateTime.now();
                          context.read<ReportsBloc>().add(
                              GetYearlyProductReportsEvent(
                                  year: currentDate.year));
                        } else if (reportType == 'Yearly' &&
                            selectedYear != null) {
                          context.read<ReportsBloc>().add(
                              GetYearlyProductReportsEvent(
                                  year: selectedYear ?? 2024));
                        } else if (reportType == 'Daily' &&
                            selectedMonth != null &&
                            selectedYear != null &&
                            selectedDate != null) {
                          context.read<ReportsBloc>().add(
                              GetDailyProductReportsEvent(
                                  date: selectedDate ?? 1,
                                  month: selectedMonth ?? 12,
                                  year: selectedYear ?? 2024));
                        } else if (reportType == '' || selectedYear == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'please choose the correct report format',
                                    style: TextStyle(color: Colors.white),
                                  )));
                        }
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
                      "Get Report",
                      style: TextStyle(
                        fontFamily: "Quicksand",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Center yearlyReportFormat() {
    return Center(
      child: DropdownButton(
          dropdownColor: const Color.fromARGB(255, 29, 66, 97),
          hint: const Text(
            "Select year :",
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 36,
          isExpanded: true,
          underline: const SizedBox(),
          style: const TextStyle(color: Colors.black, fontSize: 18),
          value: selectedYear,
          onChanged: (value) {
            setState(() {
              selectedYear = value;
            });
          },
          items: years.map((year) {
            return DropdownMenuItem(
                value: year,
                child:
                    Text('$year', style: const TextStyle(color: Colors.white)));
          }).toList()),
    );
  }

  Row monthlyReportFormat() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DropdownButton(
            dropdownColor: const Color.fromARGB(255, 29, 66, 97),
            hint: const Text(
              "Select month :",
              style: TextStyle(color: Colors.white),
            ),
            value: selectedMonth,
            onChanged: (value) {
              setState(() {
                selectedMonth = value;
              });
            },
            items: months.map((month) {
              return DropdownMenuItem(
                  value: month,
                  child: Text(month.toString(),
                      style: const TextStyle(color: Colors.white)));
            }).toList()),
        DropdownButton(
            dropdownColor: const Color.fromARGB(255, 29, 66, 97),
            hint: const Text(
              "Select day :",
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 36,
            underline: const SizedBox(),
            style: const TextStyle(color: Colors.white, fontSize: 18),
            value: selectedYear,
            onChanged: (value) {
              setState(() {
                selectedYear = value;
              });
            },
            items: years.map((year) {
              return DropdownMenuItem(
                  value: year,
                  child: Text(year.toString(),
                      style: const TextStyle(color: Colors.white)));
            }).toList()),
      ],
    );
  }

  Row dailyReportFormat() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DropdownButton(
            dropdownColor: const Color.fromARGB(255, 29, 66, 97),
            hint: const Text(
              "Day :",
              style: TextStyle(color: Colors.white),
            ),
            value: selectedDate,
            onChanged: (value) {
              setState(() {
                selectedDate = value;
                print(selectedMonth);
                print(reportType);
              });
            },
            items: days.map((day) {
              return DropdownMenuItem(
                  value: day,
                  child: Text(day.toString(),
                      style: const TextStyle(color: Colors.white)));
            }).toList()),
        DropdownButton(
            dropdownColor: const Color.fromARGB(255, 29, 66, 97),
            hint: const Text(
              "Month",
              style: TextStyle(color: Colors.white),
            ),
            value: selectedMonth,
            onChanged: (value) {
              setState(() {
                selectedMonth = value;
              });
            },
            items: months.map((month) {
              return DropdownMenuItem(
                  value: month,
                  child: Text(month.toString(),
                      style: const TextStyle(color: Colors.white)));
            }).toList()),
        DropdownButton(
            dropdownColor: const Color.fromARGB(255, 29, 66, 97),
            hint: const Text(
              "Year :",
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 36,
            underline: const SizedBox(),
            style: const TextStyle(color: Colors.white, fontSize: 18),
            value: selectedYear,
            onChanged: (value) {
              setState(() {
                selectedYear = value;
              });
            },
            items: years.map((year) {
              return DropdownMenuItem(
                  value: year,
                  child: Text(year.toString(),
                      style: const TextStyle(color: Colors.white)));
            }).toList()),
      ],
    );
  }
}
