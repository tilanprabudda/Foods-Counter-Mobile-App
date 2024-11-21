import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Page7 extends StatelessWidget {
  const Page7({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Canteen Return Cost'),
        ),
        body: const Center(
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
    final int totalProfit = args['totalProfit'] ?? 0;
    final int totalValue = args['totalValue'] ?? 0;
    final int srinhoppesreValue = args['srinhoppesreValue'] ?? 0;
    final int stringsreValue = args['stringsreValue'] ?? 0;
    final int lawariyareValue = args['lawariyareValue'] ?? 0;
    final int othersreValue = args['othersreValue'] ?? 0;
    final int prebalance = args['prebalance'] ?? 0;
    final int needtopay = args['needtopay'] ?? 0;

    void submit() {
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
          'totalProfit': totalProfit,
          'totalValue': totalValue,
          'srinhoppesreValue': srinhoppesreValue,
          'stringsreValue': stringsreValue,
          'lawariyareValue': lawariyareValue,
          'othersreValue': othersreValue,
          'totalreCost': totalreCost,
          'selectedDate': selectedDate,
          'dayOfWeek': dayOfWeek,
          'prebalance': prebalance,
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today Sells'),
        backgroundColor: Colors.green,
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
                          'Date: ${DateFormat.yMMMd().format(selectedDate)}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      const SizedBox(height: 8),
                      Text('Day of Week: $dayOfWeek', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text('Total Day Sell: Rs. $totalreCost', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text('Previous Balance in : Rs. $prebalance', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 16),
                      const Divider(height: 1, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text('Total: Rs. $needtopay', style: const TextStyle(fontSize: 16)),
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
