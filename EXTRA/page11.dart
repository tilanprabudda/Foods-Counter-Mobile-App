import 'package:flutter/material.dart';
import 'package:FoodsCounter/google_sheets_api_extra.dart';
import 'package:intl/intl.dart';

class Page11 extends StatefulWidget {
  const Page11({super.key});
  @override
  Page11State createState() => Page11State();
}

class Page11State extends State<Page11> {
  final TextEditingController _paidController = TextEditingController();
  final int _total = 0;
  int _balance = 0;
  int _paid = 0;
  final GoogleSheetsApi googleSheetsApi = GoogleSheetsApi('API Key', 'credentials.json');

  @override
  void initState() {
    super.initState();
    _fetchPreviousBalance();
  }

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
    final int paidValue = int.tryParse(_paidController.text) ?? 0;
    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      final int strhopval = args['strhopval'] ?? 0;
      final int strhopvalall = args['strhopvalall'] ?? 0;
      final int lawval = args['lawval'] ?? 0;
      final int otheval = args['otheval'] ?? 0;
      final int totalValue = args['totalValue'] ?? 0;
      final DateTime? selectedDate = args['selectedDate'] as DateTime?;
      final String dayOfWeek = args['dayOfWeek'] ?? '';
      final String name = args['name'] ?? '';

      setState(() {
        _balance = totalValue - paidValue + _balance;
        _paid = paidValue;
      });

      await googleSheetsApi.appendRow([
        strhopval,
        strhopvalall,
        lawval,
        otheval,
        totalValue,
        _total,
        _balance,
        _paid,
        selectedDate != null ? DateFormat.yMMMd().format(selectedDate) : '',
        dayOfWeek,
        name,
      ]);

      Navigator.pushNamed(
        context,
        '/',
        arguments: {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extra Production Payment'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _paidController,
              decoration: const InputDecoration(
                labelText: 'Paid Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 18),
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
