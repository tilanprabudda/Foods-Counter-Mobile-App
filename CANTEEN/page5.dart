import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Page5 extends StatelessWidget {
  const Page5({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Distribute Cost For Canteen'),
          backgroundColor: Colors.black, 
          titleTextStyle: const TextStyle(
            color: Colors.white, 
            fontSize: 20, 
          ),
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
    final int totalProfit = args['totalProfit'] ?? 0; 
    final int totalValue = args['totalValue'] ?? 0;
    final DateTime? selectedDate = args['_lastUpdateDate'] as DateTime?;
    final String dayOfWeek = args['dayOfWeek'] ?? '';
    final int strhopval = args['strhopval'] ?? 0;
    final int strhopvalall = args['strhopvalall'] ?? 0;
    final int lawval = args['lawval'] ?? 0;
    final int otheval = args['otheval'] ?? 0;

    void submit() {
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
                      Text('Day of the sale: $dayOfWeek', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text('Stringhoppes Packets Distribute count is: $strhopval', style: const TextStyle(fontSize: 16)),
                      Text('More Stringhoppes Distribute count is: $strhopvalall', style: const TextStyle(fontSize: 16)),
                      Text('Lawariya Distribute count is: $lawval', style: const TextStyle(fontSize: 16)),
                      Text('Others Distribute count is: $otheval', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 16),
                      const Divider(height: 1, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text('Total Value: Rs. $totalValue', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: submit,
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
      ),
    );
  }
}
