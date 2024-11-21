import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'google_sheets_api.dart';
import 'package:FoodsCounter/canteen/page1.dart';
import 'package:FoodsCounter/canteen/page5.dart';
import 'package:FoodsCounter/canteen/page6.dart';
import 'package:FoodsCounter/canteen/page7.dart';
import 'package:FoodsCounter/canteen/page8.dart';
import 'package:FoodsCounter/canteen/page9.dart';
import 'package:FoodsCounter/extra/page10.dart';
import 'package:FoodsCounter/extra/page11.dart';
import 'package:FoodsCounter/extra/page2.dart';
import 'package:FoodsCounter/home/page3.dart';
import 'package:FoodsCounter/distributeforcanteen/page12.dart';
import 'package:FoodsCounter/distributeforcanteen/page13.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foods Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFDFFFD6),
      ),
      home: const MyHomePage(),
      routes: {
        '/page1': (context) => const Page1(),
        '/page2': (context) => const Page2(),
        '/page3': (context) => const Page3(),
        '/page5': (context) => const Page5(),
        '/page6': (context) => const Page6(),
        '/page7': (context) => const Page7(),
        '/page8': (context) => const Page8(),
        '/page9': (context) => const Page9(),
        '/page10': (context) => const Page10(),
        '/page11': (context) => const Page11(),
        '/page12': (context) => const Page12(),
        '/page13': (context) => const Page13(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _balance = 0;
  bool _isConnected = true;
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
      final rows = await googleSheetsApi.getRows();
      if (rows.isNotEmpty) {
        final lastRow = rows.last;
        setState(() {
          _balance = int.tryParse(lastRow[16].toString()) ?? 0;
        });
        _showSuccessMessage('Data updated successfully!');
      }
    } else {
      _showConnectionError();
    }
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showConnectionError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Connection Error'),
        content: const Text(
            'No internet connection. Please check your network settings and try again.'),
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

  Widget buildCreativeButton({
    required String title,
    required Color color,
    required VoidCallback onTap,
    required Color textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.w600, 
                fontStyle: FontStyle.normal, 
                color: textColor,
                letterSpacing: 1.0, 
              ),
            ),
          ),
        ),
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
            SizedBox(
              width: 350, 
              child: GridView.count(
                crossAxisCount: 2, 
                shrinkWrap: true, 
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: <Widget>[
                  buildCreativeButton(
                    title: 'Canteen',
                    color: Colors.green[100]!,
                    onTap: () => Navigator.pushNamed(context, '/page12'),
                    textColor: Colors.green[900]!,
                  ),
                  buildCreativeButton(
                    title: 'Re Canteen',
                    color: Colors.green[100]!,
                    onTap: () => Navigator.pushNamed(context, '/page1'),
                    textColor: Colors.green[900]!,
                  ),
                  buildCreativeButton(
                    title: 'Extra',
                    color: Colors.green[100]!,
                    onTap: () => Navigator.pushNamed(context, '/page2'),
                    textColor: Colors.green[900]!,
                  ),
                  buildCreativeButton(
                    title: 'Home',
                    color: Colors.green[100]!,
                    onTap: () => Navigator.pushNamed(context, '/page3'),
                    textColor: Colors.green[900]!,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Balance: $_balance',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0), 
              child: Text(
                'Version 1.1',
                style: const TextStyle(
                  fontSize: 10, 
                  fontWeight: FontWeight.w500,
                  color: Colors.black54, 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
