import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Page9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Payment Report'),
        ),
        body: Center(
          child: Text('No data available'),
        ),
      );
    }

    final int totalreCost = args['totalreCost'] ?? 0;
    final int total = args['total'] ?? 0;
    final int balance = args['balance'] ?? 0;
    final int paid = args['paid'] ?? 0;
    final DateTime? selectedDate = args['selectedDate'] as DateTime?;
    final String dayOfWeek = args['dayOfWeek'] ?? '';

    final int strhopval = args['strhopval'] ?? 0;
    final int strhopvalall = args['strhopvalall'] ?? 0;
    final int lawval = args['lawval'] ?? 0;
    final int otheval = args['otheval'] ?? 0;
    final int srinhoppesreValue = args['srinhoppesreValue'] ?? 0;
    final int stringsreValue = args['stringsreValue'] ?? 0;
    final int lawariyareValue = args['lawariyareValue'] ?? 0;
    final int othersreValue = args['othersreValue'] ?? 0;

    void _submit() {
      Navigator.pushNamed(
        context,
        '/',
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Report'),
      ),
      body: Padding(
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
            SizedBox(height: 16),
            Text(
              'Distribution Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('StringHoppes Packet: $strhopval', style: TextStyle(fontSize: 16)),
                Text('Returns: $srinhoppesreValue', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('StringHoppes: $strhopvalall', style: TextStyle(fontSize: 16)),
                Text('Returns: $stringsreValue', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Lawariya: $lawval', style: TextStyle(fontSize: 16)),
                Text('Returns: $lawariyareValue', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Others: $otheval', style: TextStyle(fontSize: 16)),
                Text('Returns: $othersreValue', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 24),
            Divider(height: 1, color: Colors.grey),
            SizedBox(height: 24),
            Text(
              'Financial Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total Sales: Rs. $totalreCost', style: TextStyle(fontSize: 16)),
                Text('Total Payment: Rs. $paid', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total Amount: Rs. $total', style: TextStyle(fontSize: 16)),
                Text('Balance: Rs. $balance', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Home', style: TextStyle(fontSize: 18)),
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
