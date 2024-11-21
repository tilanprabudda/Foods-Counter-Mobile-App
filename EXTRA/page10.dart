import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Page10 extends StatelessWidget {
  const Page10({super.key});
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Extra Production Distribute Cost'),
        ),
        body: const Center(
          child: Text('No data available'),
        ),
      );
    }

    final int totalValue = args['totalValue'] ?? 0;
    final DateTime? selectedDate = args['selectedDate'] as DateTime?;
    final String dayOfWeek = args['dayOfWeek'] ?? '';
    final int strhopval = args['strhopval'] ?? 0;
    final int strhopvalall = args['strhopvalall'] ?? 0;
    final int lawval = args['lawval'] ?? 0;
    final int otheval = args['otheval'] ?? 0;
    final String name = args['name'] ?? 0;

    void submit() {
      Navigator.pushNamed(
        context,
        '/page11',
        arguments: {
          'name': name,
          'strhopval': strhopval,
          'strhopvalall': strhopvalall,
          'lawval': lawval,
          'otheval': otheval,
          'totalValue': totalValue,
          'selectedDate': selectedDate,
          'dayOfWeek': dayOfWeek,
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Extra Production Distribute Cost'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (selectedDate != null)
                Text(
                  'Date: ${DateFormat.yMMMd().format(selectedDate)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              const SizedBox(height: 10),
              Text(
                'Day of Week: $dayOfWeek',
                style: const TextStyle(fontSize: 18, color: Colors.green),
              ),
              const SizedBox(height: 20),
              Text(
                'Total Value: Rs. $totalValue',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: submit,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
