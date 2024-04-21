import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  DateTime? selectedDate;
  int? selectedMonth;
  int? selectedYear;

  // Firebase reference (replace with your actual reference)
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // CollectionReference? _collectionRef;

  Future<void> _getData() async {
    if (selectedDate != null) {
      print(selectedDate);
      // // Get data for specific date
      // _collectionRef = _firestore
      //     .collection('your_collection_name')
      //     .where('date', isEqualTo: selectedDate);
    } else if (selectedMonth != null && selectedYear != null) {
      print(selectedMonth);
      // // Get data for specific month and year
      // _collectionRef = _firestore
      //     .collection('your_collection_name')
      //     .where('year', isEqualTo: selectedYear)
      //     .where('month', isEqualTo: selectedMonth);
    } else {
      // Handle no selection case (optional: show all data)
      // _collectionRef = _firestore.collection('your_collection_name');
    }

    // Fetch data from Firebase
    // final querySnapshot = await _collectionRef?.get();

    // Process retrieved data (example: update UI)
    // final reportData = querySnapshot?.docs.map((doc) => doc.data()).toList();
    // Update UI with reportData
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Date pickers for selection
            Row(
              children: [
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Select Date'),
                ),
                TextButton(
                  onPressed: () => _selectMonthYear(context),
                  child: const Text('Select Month & Year'),
                ),
              ],
            ),
            // Display selected date/month/year (optional)
            if (selectedDate != null)
              Text('Selected Date: ${selectedDate!.toIso8601String()}'),
            if (selectedMonth != null && selectedYear != null)
              Text('Selected Month & Year: ${selectedMonth}/${selectedYear}'),
            // Button to generate report
            ElevatedButton(
              onPressed: _getData,
              child: const Text('Generate Report'),
            ),
            // Display report data (use reportData after fetching)
            const Divider(),
            // Your widget to display report data (e.g., ListView)
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 1),
      lastDate: DateTime.now(),
    );
    if (selected != null) {
      setState(() => selectedDate = selected);
    }
  }

  void _selectMonthYear(BuildContext context) async {
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020, 1),
      lastDate: now,
    );
    if (selectedDate != null) {
      setState(() {
        selectedMonth = DateTime.april;
        selectedYear = DateTime.now().year;
        // selectedDate = DateTime.now(); // Clear specific date selection
      });
    }
  }
}
