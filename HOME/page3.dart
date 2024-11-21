import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:FoodsCounter/google_sheets_api_home.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});
  @override
  Page3State createState() => Page3State();
}

class Page3State extends State<Page3> {
  DateTime? _selectedDate;
  final TextEditingController _srinhoppeshoController = TextEditingController();
  final TextEditingController _stringshoController = TextEditingController();
  final TextEditingController _lawariyahoController = TextEditingController();
  final TextEditingController _othershoController = TextEditingController();

  final GoogleSheetsApi googleSheetsApi = GoogleSheetsApi('API Key', 'credentials.json');

  @override
  void dispose() {
    _srinhoppeshoController.dispose();
    _stringshoController.dispose();
    _lawariyahoController.dispose();
    _othershoController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final int srinhoppeshoValue = int.tryParse(_srinhoppeshoController.text) ?? 0;
    final int stringshoValue = int.tryParse(_stringshoController.text) ?? 0;
    final int lawariyahoValue = int.tryParse(_lawariyahoController.text) ?? 0;
    final int othershoValue = int.tryParse(_othershoController.text) ?? 0;

    final String dayOfWeek = _getDayOfWeek();

    if (_selectedDate != null) {
      await googleSheetsApi.appendRow([
        srinhoppeshoValue,
        stringshoValue,
        lawariyahoValue,
        othershoValue,
        DateFormat.yMMMd().format(_selectedDate!),
        dayOfWeek,
      ]);

      Navigator.pushNamed(
        context,
        '/',
        arguments: {},
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please pick a date.'),
      ));
    }
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  String _getDayOfWeek() {
    if (_selectedDate == null) {
      return '';
    }
    return DateFormat('EEEE').format(_selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Used Page'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: const Color(0xFFDFFFD6),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickDate,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Pick a Date'),
            ),
            if (_selectedDate != null) ...[
              const SizedBox(height: 16),
              Text('Selected Date: ${DateFormat.yMMMd().format(_selectedDate!)}'),
              Text('Day of Week: ${_getDayOfWeek()}'),
            ],
            const SizedBox(height: 16),
            TextField(
              controller: _srinhoppeshoController,
              decoration: const InputDecoration(
                labelText: 'Sringhoppes',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _stringshoController,
              decoration: const InputDecoration(
                labelText: 'Extra Sringhoppes Count',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _lawariyahoController,
              decoration: const InputDecoration(
                labelText: 'Lawariya',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _othershoController,
              decoration: const InputDecoration(
                labelText: 'Others',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
