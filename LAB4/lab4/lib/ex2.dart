import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {

  double _sliderValue = 50;
  bool _isActive = false;
  String _selectedGenre = 'None';
  DateTime? _selectedDate;


  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Exercise 2 - Input Controls'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SLIDER ---
            const Text('Rating (Slider)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value; // Cập nhật biến và vẽ lại UI
                });
              },
            ),
            Text('Current value: ${_sliderValue.toInt()}'),
            const SizedBox(height: 20),

            // --- SWITCH ---
            const Text('Active (Switch)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SwitchListTile(
              title: const Text('Is movie active?'),
              value: _isActive,
              contentPadding: EdgeInsets.zero, // Xóa khoảng trắng thừa
              onChanged: (value) {
                setState(() {
                  _isActive = value;
                });
              },
            ),
            const SizedBox(height: 10),

            // --- RADIO LIST TILE ---
            const Text('Genre (RadioListTile)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: const Text('Action'),
              value: 'Action',
              groupValue: _selectedGenre,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  _selectedGenre = value!;
                });
              },
            ),


            RadioListTile<String>(
              title: const Text('Comedy'),
              value: 'Comedy',
              groupValue: _selectedGenre,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  _selectedGenre = value!;
                });
              },
            ),
            Text('Selected genre: $_selectedGenre'),
            const SizedBox(height: 30),

            // --- DATE PICKER ---
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _pickDate,
                child: const Text('Open Date Picker'),
              ),
            ),

            const SizedBox(height: 10),
            Center(
              child: Text(
                _selectedDate == null ? '' : 'Selected Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}