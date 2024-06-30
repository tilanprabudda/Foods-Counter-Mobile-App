import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:FoodsCounter/canteen/page1.dart';
import 'package:FoodsCounter/canteen/page5.dart';
import 'package:FoodsCounter/canteen/page6.dart';
import 'package:FoodsCounter/canteen/page7.dart';
import 'package:FoodsCounter/canteen/page8.dart';
import 'package:FoodsCounter/canteen/page9.dart';
import 'package:FoodsCounter/extra/page2.dart';
import 'package:FoodsCounter/extra/page10.dart';
import 'package:FoodsCounter/extra/page11.dart';
import 'package:FoodsCounter/home/page3.dart';
import 'package:FoodsCounter/page4.dart';
import 'API/google_sheets_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foods Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blue[50],
      ),
      home: MyHomePage(),
      routes: {
        '/page1': (context) => Page1(),
        '/page2': (context) => Page2(),
        '/page3': (context) => Page3(),
        '/page4': (context) => Page4(),
        '/page5': (context) => Page5(),
        '/page6': (context) => Page6(),
        '/page7': (context) => Page7(),
        '/page8': (context) => Page8(),
        '/page9': (context) => Page9(),
        '/page10': (context) => Page10(),
        '/page11': (context) => Page11()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _balance = 0;
  bool _isConnected = true;
  final GoogleSheetsApi googleSheetsApi = GoogleSheetsApi('1kkRwtFUt7YMua5glyu-8Ztif1AyGAaQ-Zbw1y_vK0sQ', 'assets/credentials.json');

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
      final rows = await googleSheetsApi.getRows();
      if (rows.isNotEmpty) {
        final lastRow = rows.last;
        setState(() {
          _balance = int.tryParse(lastRow[16].toString()) ?? 0;
        });
      }
    } else {
      _showConnectionError();
    }
  }

  Future<void> _refreshData() async {
    await _checkConnectivity();
    if (_isConnected) {
      await _fetchPreviousBalance();
    } else {
      _showConnectionError();
    }
  }

  void _showConnectionError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Connection Error'),
        content: Text('No internet connection. Please check your network settings and try again.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Card(
                color: Colors.blue[100],
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: ListTile(
                    title: Center(
                      child: Text(
                        'Distribute for Canteen',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/page1');
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Card(
                color: Colors.green[100],
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: ListTile(
                    title: Center(
                      child: Text(
                        'Distribute for Extra Order',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.green[900],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/page2');
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Card(
                color: Colors.red[100],
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: ListTile(
                    title: Center(
                      child: Text(
                        'Production for home',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.red[900],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/page3');
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Card(
                color: Colors.orange[100],
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: ListTile(
                    title: Center(
                      child: Text(
                        'Check the Balance in Last Time',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.orange[900],
                        ),
                      ),
                    ),
                    onTap: _refreshData,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),
            Text(
              'Balance to be Pay: $_balance',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
