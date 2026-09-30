import 'package:flutter/material.dart';

class CommonUIFixes extends StatefulWidget {
  const CommonUIFixes({Key? key}) : super(key: key);

  @override
  State<CommonUIFixes> createState() => _CommonUIFixesState();
}

class _CommonUIFixesState extends State<CommonUIFixes> {
  String selectedDateText = "No date selected";

  // Task 4: Fix DatePicker build context errors bằng cách truyền BuildContext hợp lệ
  void _showDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDateText = "Selected: ${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 – Common UI Fixes'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Correct ListView inside Column using Expanded',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          
          Expanded(
            child: ListView(
              children: const [
                ListTile(leading: Icon(Icons.movie), title: Text('Movie A')),
                ListTile(leading: Icon(Icons.movie), title: Text('Movie B')),
                ListTile(leading: Icon(Icons.movie), title: Text('Movie C')),
                ListTile(leading: Icon(Icons.movie), title: Text('Movie D')),
              ],
            ),
          ),

          // Task 2: Fix overflow bằng SingleChildScrollView bọc phần giao diện tĩnh
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(selectedDateText, style: const TextStyle(color: Colors.blue)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _showDatePicker(context),
                    child: const Text('Open Date Picker'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}