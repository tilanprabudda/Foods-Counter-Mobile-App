import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Distribute Cost For Canteen'),
        ),
        body: Center(
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

    void _submit() {
      Navigator.pushNamed(
        context,
        '/page6',
        arguments: {
          'strhopval': strhopval,
          'strhopvalall': strhopvalall,
          'lawval': lawval,
          'otheval': otheval,
          'stringCost': stringCost,
          'lawariyaCost': lawariyaCost,
          'coconutCost': coconutCost,
          'totalCost': totalCost,
          'totalProfit': totalProfit,
          'totalValue': totalValue,
          'selectedDate': selectedDate,
          'dayOfWeek': dayOfWeek,
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Distribute Cost For Canteen'),
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
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      SizedBox(height: 8),
                      Text('Day of Week: $dayOfWeek', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text('Stringhoppes Cost is Rs.: $stringCost', style: TextStyle(fontSize: 16)),
                      Text('Lawariya Cost is Rs.: $lawariyaCost', style: TextStyle(fontSize: 16)),
                      Text('Coconut Cost is Rs.: $coconutCost', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 16),
                      Divider(height: 1, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Total Cost: Rs. $totalCost', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Total Value: Rs. $totalValue', style: TextStyle(fontSize: 16)),
                      Text('Total Profit: Rs. $totalProfit', style: TextStyle(fontSize: 16)),
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
