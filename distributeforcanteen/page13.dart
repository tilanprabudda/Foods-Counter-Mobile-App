import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:FoodsCounter/google_sheet_api_canteen.dart';

class Page13 extends StatelessWidget {
  const Page13({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Distribute Cost For Canteen'),
        ),
        body: const Center(
          child: Text('No data available'),
        ),
      );
    }

    final int stringCost = args['stringCost'] ?? 0;
    final int lawariyaCost = args['lawariyaCost'] ?? 0;
    final int coconutCost = args['coconutCost'] ?? 0;
    final int totalCost = args['totalCost'] ?? 0;
    final int totalProfit = args['totalProft'] ?? 0;
    final int totalValue = args['totalValue'] ?? 0;
    final DateTime? selectedDate = args['selectedDate'] as DateTime?;
    final String dayOfWeek = args['dayOfWeek'] ?? '';
    final int strhopval = args['strhopval'] ?? 0;
    final int strhopvalall = args['strhopvalall'] ?? 0;
    final int lawval = args['lawval'] ?? 0;
    final int otheval = args['otheval'] ?? 0;

    final GoogleSheetsApi googleSheetsApi = GoogleSheetsApi(
      'API Key',
      'credentials.json',
    );

    Future<void> submit(BuildContext context) async {
      try {
        await googleSheetsApi.appendRow([
          strhopval,
          strhopvalall,
          lawval,
          otheval,
          stringCost,
          lawariyaCost,
          coconutCost,
          totalCost,
          totalValue,
          selectedDate != null ? DateFormat.yMMMd().format(selectedDate) : '',
          dayOfWeek,
        ]);

        Navigator.pushNamed(context, '/');
      } catch (e) {
        
        _showErrorDialog(context, 'Failed to submit data: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Distribute Cost For Canteen'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
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
                      if (selectedDate != null)
                        Text(
                          'Date: ${DateFormat.yMMMd().format(selectedDate)}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      const SizedBox(height: 8),
                      Text('Day of Week: $dayOfWeek', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text('Stringhoppes Cost: Rs. $stringCost', style: const TextStyle(fontSize: 16)),
                      Text('Lawariya Cost: Rs. $lawariyaCost', style: const TextStyle(fontSize: 16)),
                      Text('Coconut Cost: Rs. $coconutCost', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 16),
                      const Divider(height: 1, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text('Total Value: Rs. $totalValue', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Total Cost: Rs. $totalCost', style: const TextStyle(fontSize: 16)),
                      Text('Total Profit: Rs. $totalProfit', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => submit(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Submit', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
