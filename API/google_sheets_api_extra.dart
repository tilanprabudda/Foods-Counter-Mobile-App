import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleSheetsApi {
  static const _scopes = [SheetsApi.spreadsheetsScope];

  final String _spreadsheetId;
  final String _credentialsPath;

  SheetsApi? _sheetsApi;

  GoogleSheetsApi(this._spreadsheetId, this._credentialsPath);

  Future<void> _init() async {
    final credentials = jsonDecode(await rootBundle.loadString(_credentialsPath));
    final accountCredentials = ServiceAccountCredentials.fromJson(credentials);

    final authClient = await clientViaServiceAccount(accountCredentials, _scopes);
    _sheetsApi = SheetsApi(authClient);
  }

  Future<void> appendRow(List<dynamic> row) async {
    await _init();

    final valueRange = ValueRange.fromJson({
      'values': [row]
    });

    await _sheetsApi!.spreadsheets.values.append(
      valueRange,
      _spreadsheetId,
      'Sheet1!A1',
      valueInputOption: 'RAW',
    );
  }

  Future<List<List<dynamic>>> getRows() async {
    await _init();

    final response = await _sheetsApi!.spreadsheets.values.get(
      _spreadsheetId,
      'Sheet1!A1:Z1000',
    );

    return response.values ?? [];
  }

  static Future<SheetsApi> _getSheetsApi() async {
    final credentials = await rootBundle.loadString('assets/credentialsextra.json');
    final credentialsMap = json.decode(credentials);

    final authClient = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(credentialsMap),
      _scopes,
    );

    return SheetsApi(authClient);
  }

  static Future<List<Map<String, dynamic>>> fetchData(String spreadsheetId, String range) async {
    final sheetsApi = await _getSheetsApi();
    final response = await sheetsApi.spreadsheets.values.get(spreadsheetId, range);

    final rows = response.values;
    if (rows == null || rows.isEmpty) return [];

    final headers = rows.first;
    return rows.skip(1).map((row) {
      return Map<String, dynamic>.fromIterables(headers as Iterable<String>, row);
    }).toList();
  }

  static Future<void> submitData(String spreadsheetId, String range, List<List<Object>> values) async {
    final sheetsApi = await _getSheetsApi();
    ValueRange request = ValueRange.fromJson({"values": values});

    await sheetsApi.spreadsheets.values.append(
      request,
      spreadsheetId,
      range,
      valueInputOption: 'RAW',
    );
  }
}
