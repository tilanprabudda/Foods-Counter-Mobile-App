import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Page7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Canteen Return Cost'),
        ),
        body: Center(
          child: Text('No data available'),
        ),
      );
    }

    final int totalreCost = args['totalreCost'] ?? 0;
    final DateTime? selectedDate = args['selectedDate'] as DateTime?;
    final String dayOfWeek = args['dayOfWeek'] ?? '';

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
    final int balanceValue = args['balance'] ?? 0;

    void _submit() {
      Navigator.pushNamed(
        context,
        '/page8',
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
          'selectedDate': selectedDate,
          'dayOfWeek': dayOfWeek,
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Today Sells'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          'Date: ${DateFormat.yMMMd().format(selectedDate!)}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      SizedBox(height: 8),
                      Text('Day of Week: $dayOfWeek', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text('Total Day Sell: Rs. $totalreCost', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text('Previous Balance in : Rs. $balanceValue', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
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
      ),
    );
  }
}
