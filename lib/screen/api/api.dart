import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static const _baseUrl = 'http://user-service.pokee.app/v1/user';

  Future<http.Response> getUser(String userId) async {
    return await http.get(Uri.parse('$_baseUrl/$userId'));
  }

  Future<http.Response> postUser(Map<String, String> user) async {
    final encodedBody = jsonEncode(user);
    final response = await http.post(Uri.parse('$_baseUrl/'),body: encodedBody, headers: {"Content-Type": "application/json"},);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}
