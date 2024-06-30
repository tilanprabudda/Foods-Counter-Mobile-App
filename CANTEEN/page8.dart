import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:FoodsCounter/API/google_sheets_api.dart';

class Page8 extends StatefulWidget {
  @override
  _Page8State createState() => _Page8State();
}

class _Page8State extends State<Page8> {
  final TextEditingController _paidController = TextEditingController();
  int _total = 0;
  int _balance = 0;
  int _paid = 0;
  final GoogleSheetsApi googleSheetsApi = GoogleSheetsApi('1kkRwtFUt7YMua5glyu-8Ztif1AyGAaQ-Zbw1y_vK0sQ', 'assets/credentials.json');

  Future<void> _fetchPreviousBalance() async {
    final rows = await googleSheetsApi.getRows();
    if (rows.isNotEmpty) {
      final lastRow = rows.last;
      setState(() {
        _balance = int.tryParse(lastRow[16].toString()) ?? 0;
      });
    }
  }

  Future<void> _submit() async {
    await _fetchPreviousBalance();

    final int paidValue = int.tryParse(_paidController.text) ?? 0;
    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      final int strhopval = args['strhopval'] ?? 0;
      final int strhopvalall = args['strhopvalall'] ?? 0;
      final int lawval = args['lawval'] ?? 0;
      final int otheval = args['otheval'] ?? 0;
      final int stringCost = args['stringCost'] ?? 0;
      final int lawariyaCost = args['lawariyaCost'] ?? 0;
      final int coconutCost = args['coconutCost'] ?? 0;
      final int totalCost = args['totalCost'] ?? 0;
      final int totalProft = args['totalProft'] ?? 0;
      final int totalValue = args['totalValue'] ?? 0;
      final int srinhoppesreValue = args['srinhoppesreValue'] ?? 0;
      final int stringsreValue = args['stringsreValue'] ?? 0;
      final int lawariyareValue = args['lawariyareValue'] ?? 0;
      final int othersreValue = args['othersreValue'] ?? 0;
      final int totalreCost = args['totalreCost'] ?? 0;
      final DateTime? selectedDate = args['selectedDate'] as DateTime?;
      final String dayOfWeek = args['dayOfWeek'] ?? '';

      setState(() {
        _total = totalreCost;
        _balance = _total - paidValue + _balance;
        _paid = paidValue;
      });

      await googleSheetsApi.appendRow([
        strhopval,
        strhopvalall,
        lawval,
        otheval,
        stringCost,
        lawariyaCost,
        coconutCost,
        totalCost,
        totalProft,
        totalValue,
        srinhoppesreValue,
        stringsreValue,
        lawariyareValue,
        othersreValue,
        totalreCost,
        _total,
        _balance,
        _paid,
        selectedDate != null ? DateFormat.yMMMd().format(selectedDate) : '',
        dayOfWeek,
      ]);

      Navigator.pushNamed(
        context,
        '/page9',
        arguments: {
          'strhopval': strhopval,
          'strhopvalall': strhopvalall,
          'lawval': lawval,
          'otheval': otheval,
          'stringCost': stringCost,
          'lawariyaCost': lawariyaCost,
          'coconutCost': coconutCost,
          'totalCost': totalCost,
          'totalProft': totalProft,
          'totalValue': totalValue,
          'srinhoppesreValue': srinhoppesreValue,
          'stringsreValue': stringsreValue,
          'lawariyareValue': lawariyareValue,
          'othersreValue': othersreValue,
          'totalreCost': totalreCost,
          'total': _total,
          'balance': _balance,
          'paid': _paid,
          'selectedDate': selectedDate,
          'dayOfWeek': dayOfWeek,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page For Canteen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _paidController,
              decoration: InputDecoration(
                labelText: 'Paid Amount (Rs.)',
                border: OutlineInputBorder(),
                hintText: 'Enter the amount paid',
                prefixIcon: Icon(Icons.payment),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Upload Data', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
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
