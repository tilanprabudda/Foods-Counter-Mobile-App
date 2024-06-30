import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  DateTime? _selectedDate;
  final TextEditingController _srinhoppesexController = TextEditingController();
  final TextEditingController _stringsexController = TextEditingController();
  final TextEditingController _lawariyaexController = TextEditingController();
  final TextEditingController _othersexController = TextEditingController();

  int _totalValue = 0;
  int _strhopval = 0;
  int _strhopvalall = 0;
  int _lawval = 0;
  int _otheval = 0;

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

  void _calculateCosts(int srinhoppesexValue, int stringsexValue, int lawariyaexValue, int othersexValue) {
    _totalValue = srinhoppesexValue * 50 + stringsexValue * 5 + lawariyaexValue * 50 + othersexValue;
    _strhopval = srinhoppesexValue;
    _strhopvalall = stringsexValue;
    _lawval = lawariyaexValue;
    _otheval = othersexValue;
  }

  void _submit() {
    final int srinhoppesexValue = int.tryParse(_srinhoppesexController.text) ?? 0;
    final int stringsexValue = int.tryParse(_stringsexController.text) ?? 0;
    final int lawariyaexValue = int.tryParse(_lawariyaexController.text) ?? 0;
    final int othersexValue = int.tryParse(_othersexController.text) ?? 0;

    setState(() {
      _calculateCosts(srinhoppesexValue, stringsexValue, lawariyaexValue, othersexValue);
    });

    Navigator.pushNamed(
      context,
      '/page10',
      arguments: {
        'strhopval': _strhopval,
        'strhopvalall': _strhopvalall,
        'lawval': _lawval,
        'otheval': _otheval,
        'totalValue': _totalValue,
        'selectedDate': _selectedDate,
        'dayOfWeek': _getDayOfWeek(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extra Production Page'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickDate,
              child: Text('Pick a date'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            if (_selectedDate != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Date:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat.yMMMd().format(_selectedDate!),
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Day of Week:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _getDayOfWeek(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(),
                ],
              ),
            TextField(
              controller: _srinhoppesexController,
              decoration: InputDecoration(
                labelText: 'Sringhoppes Packets',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _stringsexController,
              decoration: InputDecoration(
                labelText: 'Extra Sringhoppes Count',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _lawariyaexController,
              decoration: InputDecoration(
                labelText: 'Lawariya',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _othersexController,
              decoration: InputDecoration(
                labelText: 'Others',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
