import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:FoodsCounter/API/google_sheets_api_home.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  DateTime? _selectedDate;
  final TextEditingController _srinhoppeshoController = TextEditingController();
  final TextEditingController _stringshoController = TextEditingController();
  final TextEditingController _lawariyahoController = TextEditingController();
  final TextEditingController _othershoController = TextEditingController();

  final GoogleSheetsApi googleSheetsApi = GoogleSheetsApi('1vGEqf1_jTVK3LV7v62y-uFMrzgFxW1BWslN8dhOwLKQ', 'assets/credentialshome.json');

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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
        title: Text('Home Used Page'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickDate,
              child: Text('Pick a Date'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            if (_selectedDate != null) ...[
              SizedBox(height: 16),
              Text('Selected Date: ${DateFormat.yMMMd().format(_selectedDate!)}'),
              Text('Day of Week: ${_getDayOfWeek()}'),
            ],
            SizedBox(height: 16),
            TextField(
              controller: _srinhoppeshoController,
              decoration: InputDecoration(
                labelText: 'Sringhoppes',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            TextField(
              controller: _stringshoController,
              decoration: InputDecoration(
                labelText: 'Extra Sringhoppes Count',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            TextField(
              controller: _lawariyahoController,
              decoration: InputDecoration(
                labelText: 'Lawariya',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            TextField(
              controller: _othershoController,
              decoration: InputDecoration(
                labelText: 'Others',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
