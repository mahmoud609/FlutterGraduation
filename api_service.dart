import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://localhost:7030/api/User'; // رابط الـ API

  Future<void> createUser(String name, String email) async {
    final url = Uri.parse(baseUrl);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
      }),
    );

    if (response.statusCode == 201) {
      print('User created successfully!');
    } else {
      print('Failed to create user: ${response.body}');
    }
  }
}
