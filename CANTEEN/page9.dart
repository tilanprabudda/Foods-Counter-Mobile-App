import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_sheet_api_canteen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class Page9 extends StatefulWidget {
  const Page9({super.key});

  @override
  _Page9State createState() => _Page9State();
}

class _Page9State extends State<Page9> {
  bool _isSubmitting = false;

  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      throw Exception('Storage permission is required to save the PDF.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Payment Report'),
        ),
        body: const Center(
          child: Text('No data available'),
        ),
      );
    }

    final int totalreCost = args['totalreCost'] ?? 0;
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
    final int prebalance = args['prebalance'] ?? 0;

    final GoogleSheetsApi googleSheetsApi = GoogleSheetsApi(
      'API Key',
      'credentials.json',
    );

    void showErrorDialog(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    Future<void> submit(BuildContext context) async {
      try {
        setState(() => _isSubmitting = true);

        await googleSheetsApi.appendRow([0, 0, 0, 0, 0, 0, 0, 0]);

        await generatePDF(
          context,
          totalreCost,
          balance,
          paid,
          prebalance,
          strhopval,
          strhopvalall,
          lawval,
          otheval,
          srinhoppesreValue,
          stringsreValue,
          lawariyareValue,
          othersreValue,
          dayOfWeek,
        );

        Navigator.pushNamed(context, '/');
      } catch (e) {
        showErrorDialog(context, 'Failed to submit data: $e');
      } finally {
        setState(() => _isSubmitting = false);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Report'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: const Color(0xFFDFFFD6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (selectedDate != null)
                Text(
                  'Date: ${DateFormat.yMMMd().format(selectedDate)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 8),
              Text('Day of Week: $dayOfWeek',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              const Text(
                'Distribution Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildSummaryRow('StringHoppes Packet', strhopval,
                  srinhoppesreValue),
              _buildSummaryRow('StringHoppes', strhopvalall, stringsreValue),
              _buildSummaryRow('Lawariya', lawval, lawariyareValue),
              _buildSummaryRow('Others', otheval, othersreValue),
              const SizedBox(height: 24),
              const Divider(height: 1),
              const SizedBox(height: 24),
              const Text(
                'Financial Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildFinancialSummaryRow('Total Sales', totalreCost),
              _buildFinancialSummaryRow('Previse Balance', prebalance),
              _buildFinancialSummaryRow('Total Payment', paid),
              _buildFinancialSummaryRow('New Balance', balance),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSubmitting ? null : () => submit(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text('Submit', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title1, int value1, int value2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('$title1: $value1', style: const TextStyle(fontSize: 16)),
        Text('Returns: $value2', style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildFinancialSummaryRow(String title, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('$title: Rs. $value', style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Future<void> generatePDF(
      BuildContext context,
      int totalreCost,
      int balance,
      int paid,
      int prebalance,
      int strhopval,
      int strhopvalall,
      int lawval,
      int otheval,
      int srinhoppesreValue,
      int stringsreValue,
      int lawariyareValue,
      int othersreValue,
      String dayOfWeek) async {
    try {
      await requestStoragePermission();

      final pdf = pw.Document();
      final String formattedDate = DateFormat('yyyyMMdd').format(DateTime.now());
      final String formattedReadableDate =
      DateFormat.yMMMd().format(DateTime.now());

      Directory? directory = await getExternalStorageDirectory();
      final file = File('${directory?.path}/payment_report_$formattedDate.pdf');

      final ByteData logoData = await rootBundle.load('assets/icon/icon.png');
      final Uint8List logoBytes = logoData.buffer.asUint8List();
      final pw.ImageProvider logoImage = pw.MemoryImage(logoBytes);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Image(logoImage, height: 80, width: 80),
                ),
                pw.SizedBox(height: 16),

                pw.Text(
                  'Foods Counter',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 16),
                
                pw.Text(
                  'Payment Report',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 16),

                pw.Text('Date: $formattedReadableDate',
                    style: pw.TextStyle(fontSize: 16)),
                pw.Text('Day of Week: $dayOfWeek',
                    style: pw.TextStyle(fontSize: 16)),
                pw.SizedBox(height: 24),

                pw.Text('Distribution Summary:',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 8),
                _buildPDFRow('StringHoppes Packet:', strhopval,
                    'Returns:', srinhoppesreValue),
                _buildPDFRow('StringHoppes:', strhopvalall, 'Returns:',
                    stringsreValue),
                _buildPDFRow('Lawariya:', lawval, 'Returns:', lawariyareValue),
                _buildPDFRow('Others:', otheval, 'Returns:', othersreValue),
                pw.SizedBox(height: 24),

                pw.Text('Financial Summary:',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 8),
                _buildPDFRow('Total Sales:', totalreCost, null, null),
                _buildPDFRow('Previse Balance:', prebalance, null, null),
                _buildPDFRow('Total Payment:', paid, null, null),
                _buildPDFRow('New Balance:', balance, null, null),
                pw.SizedBox(height: 32),

                pw.Divider(),
                pw.SizedBox(height: 8),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'Version 1.1\nThis is an e-bill for the generated copy.',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic),
                  ),
                ),
              ],
            );
          },
        ),
      );

      await file.writeAsBytes(await pdf.save());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved successfully at: ${file.path}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save PDF: $e')),
      );
    }
  }

  pw.Widget _buildPDFRow(String label1, int? value1, String? label2, int? value2) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          '$label1 ${value1 ?? ''}',
          style: pw.TextStyle(fontSize: 14),
        ),
        if (label2 != null && value2 != null)
          pw.Text(
            '$label2 $value2',
            style: pw.TextStyle(fontSize: 14),
          ),
      ],
    );
  }

}
