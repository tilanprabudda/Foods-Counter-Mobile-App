import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});
  @override
  Page2State createState() => Page2State();
}

class Page2State extends State<Page2> {
  DateTime? _selectedDate;
  final TextEditingController _srinhoppesexController = TextEditingController();
  final TextEditingController _stringsexController = TextEditingController();
  final TextEditingController _lawariyaexController = TextEditingController();
  final TextEditingController _othersexController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
    _totalValue = srinhoppesexValue * value1 + stringsexValue * value2 + lawariyaexValue * value3 + othersexValue;
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
    final String name = _nameController.text.trim();

    setState(() {
      _calculateCosts(srinhoppesexValue, stringsexValue, lawariyaexValue, othersexValue);
    });

    Navigator.pushNamed(
      context,
      '/page10',
      arguments: {
        'name': name,
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
        title: const Text('Extra Production Page'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: const Color(0xFFDFFFD6),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickDate,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Pick a date'),
            ),
            const SizedBox(height: 10),
            if (_selectedDate != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected Date:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat.yMMMd().format(_selectedDate!),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Day of Week:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _getDayOfWeek(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Divider(),
                ],
              ),
            TextField(
              controller: _srinhoppesexController,
              decoration: const InputDecoration(
                labelText: 'Sringhoppes Packets',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _stringsexController,
              decoration: const InputDecoration(
                labelText: 'Extra Sringhoppes Count',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _lawariyaexController,
              decoration: const InputDecoration(
                labelText: 'Lawariya',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _othersexController,
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
