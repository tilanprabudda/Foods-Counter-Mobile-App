import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'google_sheet_api_canteen.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  Page1State createState() => Page1State();
}

class Page1State extends State<Page1> {
  DateTime? _lastUpdateDate;
  int stringCost = 0;
  int lawariyaCost = 0;
  int coconutCost = 0;
  int totalCost = 0;
  int totalProfit = 0;
  int totalValue = 0;
  DateTime? selectedDate;
  String dayOfWeek = '';
  int strhopval = 0;
  int strhopvalall = 0;
  int lawval = 0;
  int otheval = 0;

  bool _isConnected = true;
  bool _isDataUpdated = false;
  final GoogleSheetsApi googleSheetsApi = GoogleSheetsApi(
    'API Key',
    'credentials.json',
  );

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _fetchPreviousBalance();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  Future<void> _fetchPreviousBalance() async {
    if (_isConnected) {
      try {
        final rows = await googleSheetsApi.getRows();
        if (rows.isNotEmpty) {
          final lastRow = rows.last;
          setState(() {
            strhopval = _getValueFromRow(lastRow, 0);
            strhopvalall = _getValueFromRow(lastRow, 1);
            lawval = _getValueFromRow(lastRow, 2);
            otheval = _getValueFromRow(lastRow, 3);
            totalCost = _getValueFromRow(lastRow, 7);
            selectedDate = _getDateFromRow(lastRow, 9);
            dayOfWeek = _getStringFromRow(lastRow, 10);
            _lastUpdateDate = DateTime.now();
            _isDataUpdated = true;
          });
        } else {
          setState(() {
            _isDataUpdated = false; 
          });
        }
      } catch (e) {
        _showErrorDialog('Error fetching data: $e');
      }
    } else {
      _showConnectionError();
    }
  }

  int _getValueFromRow(List<dynamic> row, int index) {
    if (index < row.length) {
      return int.tryParse(row[index]?.toString() ?? '0') ?? 0;
    }
    return 0;
  }

  String _getStringFromRow(List<dynamic> row, int index) {
    if (index < row.length) {
      return row[index]?.toString() ?? '';
    }
    return '';
  }

  DateTime? _getDateFromRow(List<dynamic> row, int index) {
    if (index < row.length) {
      return DateTime.tryParse(row[index]?.toString() ?? '');
    }
    return null;
  }

  void _showConnectionError() {
    _showErrorDialog('No internet connection. Please check your network settings and try again.');
  }

  void _showErrorDialog(String message) {
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

  void _calculateCosts(int strhopval, int strhopvalall, int lawval, int otheval) {
    setState(() {
      totalValue = strhopval * 50 + strhopvalall * 5 + lawval * 50 + otheval;
      coconutCost = (80 * (0.005 * ((10 * strhopval) + lawval) + (0.05 * otheval))).toInt();
      stringCost = (2.4 * ((10 * strhopval) + strhopvalall)).toInt();
      lawariyaCost = (17 * lawval).toInt();
      totalCost = stringCost + lawariyaCost;
      totalProfit = totalValue - totalCost;
    });
  }

  void _submit() {
    _calculateCosts(strhopval, strhopvalall, lawval, otheval);

    Navigator.pushNamed(
      context,
      '/page5',
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
        '_lastUpdateDate': _lastUpdateDate,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _isDataUpdated ? _submit : null, 
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: _isDataUpdated ? Colors.green : Colors.grey,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                _isDataUpdated
                    ? 'Data Updated Successfully!'
                    : 'Waiting to See Check the Last Update',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 30),
            if (!_isDataUpdated) ...[
              Text(
                'Error: Failed to update data. Please try again.',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

