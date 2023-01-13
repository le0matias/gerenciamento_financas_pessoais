import 'package:http/http.dart' as http;
import 'dart:convert';

class RestUtil {
  static String urlBase = 'web-production-6577.up.railway.app';

  static Future<http.Response> addData(String uri, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.https(urlBase, uri),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(data),
    );
    return response;
  }

  static Future<http.Response> getData(String uri) async {
    final response = await http.get(
      Uri.https(urlBase, uri)
    );
    return response;
  }
}