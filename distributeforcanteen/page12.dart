import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Page12 extends StatefulWidget {
  const Page12({super.key});
  @override
  Page12State createState() => Page12State();
}

class Page12State extends State<Page12> {
  DateTime? _selectedDate;
  final TextEditingController _srinhoppesController = TextEditingController();
  final TextEditingController _stringsController = TextEditingController();
  final TextEditingController _lawariyaController = TextEditingController();
  final TextEditingController _othersController = TextEditingController();

  int _totalValue = 0;
  int _totalProft = 0;
  int _totalCost = 0;
  int _stringCost = 0;
  int _lawariyaCost = 0;
  int _coconutCost = 0;
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

  void _calculateCosts(int srinhoppesValue, int stringsValue, int lawariyaValue, int othersValue) {
    _totalValue = srinhoppesValue * value1 + stringsValue * value2 + lawariyaValue * value3 + othersValue;
    _coconutCost = equation1;
    _stringCost = equation2;
    _lawariyaCost = equation3;
    _totalCost = _stringCost + _lawariyaCost;
    _totalProft = _totalValue - _totalCost;
    _strhopval = srinhoppesValue;
    _strhopvalall = stringsValue;
    _lawval = lawariyaValue;
    _otheval = othersValue;
  }

  void _submit() {
    final int srinhoppesValue = int.tryParse(_srinhoppesController.text) ?? 0;
    final int stringsValue = int.tryParse(_stringsController.text) ?? 0;
    final int lawariyaValue = int.tryParse(_lawariyaController.text) ?? 0;
    final int othersValue = int.tryParse(_othersController.text) ?? 0;

    setState(() {
      _calculateCosts(srinhoppesValue, stringsValue, lawariyaValue, othersValue);
    });

    Navigator.pushNamed(
      context,
      '/page13',
      arguments: {
        'strhopval': _strhopval,
        'strhopvalall': _strhopvalall,
        'lawval': _lawval,
        'otheval': _otheval,
        'stringCost': _stringCost,
        'lawariyaCost': _lawariyaCost,
        'coconutCost': _coconutCost,
        'totalCost': _totalCost,
        'totalProft': _totalProft,
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
        title: const Text('Distribute Page For Canteen'),
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
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Select a date', style: TextStyle(fontSize: 18)),
            ),

            const SizedBox(height: 16),
            if (_selectedDate != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selected Date: ${DateFormat.yMMMd().format(_selectedDate!)}', style: const TextStyle(fontSize: 16)),
                  Text('Day of Week: ${_getDayOfWeek()}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),
                ],
              ),
            TextField(
              controller: _srinhoppesController,
              decoration: const InputDecoration(
                labelText: 'Sringhoppes Packets',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _stringsController,
              decoration: const InputDecoration(
                labelText: 'Extra Sringhoppes Count',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lawariyaController,
              decoration: const InputDecoration(
                labelText: 'Lawariya',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _othersController,
              decoration: const InputDecoration(
                labelText: 'Others',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Next', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
