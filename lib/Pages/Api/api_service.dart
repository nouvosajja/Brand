import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<dynamic> fetchData(String endpoint, {Map<String, dynamic>? body, bool isPost = false}) async {
    final url = Uri.parse("$baseUrl$endpoint");

    if (isPost) {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    }
  }
}
