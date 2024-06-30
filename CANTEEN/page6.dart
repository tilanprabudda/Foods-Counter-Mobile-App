import 'package:flutter/material.dart';
import 'package:FoodsCounter/API/google_sheets_api.dart';

class Page6 extends StatefulWidget {
  @override
  _Page6State createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  final TextEditingController _srinhoppesreController = TextEditingController();
  final TextEditingController _stringsreController = TextEditingController();
  final TextEditingController _lawariyareController = TextEditingController();
  final TextEditingController _othersreController = TextEditingController();
  int _totalreValue = 0;
  int _totalreCost = 0;
  int _balance = 0;
  final GoogleSheetsApi googleSheetsApi = GoogleSheetsApi('1kkRwtFUt7YMua5glyu-8Ztif1AyGAaQ-Zbw1y_vK0sQ', 'assets/credentials.json');

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

  void _submit() {
    final int srinhoppesreValue = int.tryParse(_srinhoppesreController.text) ?? 0;
    final int stringsreValue = int.tryParse(_stringsreController.text) ?? 0;
    final int lawariyareValue = int.tryParse(_lawariyareController.text) ?? 0;
    final int othersreValue = int.tryParse(_othersreController.text) ?? 0;

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
      final DateTime? selectedDate = args['selectedDate'] as DateTime?;
      final String dayOfWeek = args['dayOfWeek'] ?? '';

      setState(() {
        _totalreValue = srinhoppesreValue * 50 + stringsreValue * 5 + lawariyareValue * 50 + othersreValue;
        _totalreCost = totalValue - _totalreValue;
      });

      Navigator.pushNamed(
        context,
        '/page7',
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
          'totalreCost': _totalreCost,
          'selectedDate': selectedDate,
          'dayOfWeek': dayOfWeek,
          'srinhoppesreValue': srinhoppesreValue,
          'stringsreValue': stringsreValue,
          'lawariyareValue': lawariyareValue,
          'othersreValue': othersreValue,
          'balance': _balance
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Return Page For Canteen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: _srinhoppesreController,
                      decoration: InputDecoration(labelText: 'Sringhoppes Packet'),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _stringsreController,
                      decoration: InputDecoration(labelText: 'Extra Sringhoppes Count'),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _lawariyareController,
                      decoration: InputDecoration(labelText: 'Lawariya'),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _othersreController,
                      decoration: InputDecoration(labelText: 'Others'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _submit();
              },
              child: Text('Next', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
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
