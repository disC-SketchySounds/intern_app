import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// Service for accessing the SketchySounds API as a Singleton class
class APIService {
  static final APIService instance = APIService._();

  static String apiUrl = 'http://localhost:4242';
  static const apiVersion = 'v1';
  static String apiEndpoint = '$apiUrl/api/$apiVersion';

  /// private constructor
  APIService._();

  /// Save sketch to files, return path
  Future<String> getLastSketch() async {
    final uri = Uri.parse('$apiEndpoint/last-score');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String filePath = '${dir.path}/lastScore-$timestamp.jpeg';
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } else if (response.statusCode == 204) {
      throw Exception("No data yet");
    } else if (response.statusCode == 404) {
      throw Exception("No last transaction");
    } else {
      var responseData = json.decode(response.body);
      String errorMessage = responseData['message'] ?? 'Unknown error occurred';
      throw Exception(errorMessage);
    }
  }
}
