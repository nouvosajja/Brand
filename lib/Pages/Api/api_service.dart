// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// class ApiService {
//   final String baseUrl;

//   ApiService(this.baseUrl);

//   Future<dynamic> fetchData(
//     String endpoint, {
//     Map<String, dynamic>? body,
//     bool isPost = false,
//     Map<String, String>? headers, 
//     String? authToken,
//   }) async {
//     final url = Uri.parse("$baseUrl$endpoint");

//     // if (isPost) {
//     //   final response = await http.post(
//     //     url,
//     //     headers: headers, // Gunakan headers yang diberikan
//     //     body: jsonEncode(body),
//     //   );

//     //   if (response.statusCode == 200) {
//     //     print(response.body);
//     //     return jsonDecode(response.body);
//     //   } else {
//     //     throw Exception('Failed to load data');
//     //   }
//     // } else {
//     //   final response = await http.get(
//     //     url,
//     //     headers: headers, // Gunakan headers yang diberikan
//     //   );

//     //   if (response.statusCode == 200) {
//     //     print(response.body);
//     //     return jsonDecode(response.body);
//     //   } else {
//     //     throw Exception('Failed to load data');
//     //   }
//     // }

//     if (isPost) {
//       final response = await http.post(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(body),
//       );

//       if (response.statusCode == 200) {
//         print(response.body);
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } else {
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         print(response.body);
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('Failed to load data');
//       }
//     }
//   }
// }



import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_config.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<dynamic> fetchData(
    String endpoint, {
    Map<String, dynamic>? body,
    bool isPost = false,
    Map<String, String>? headers,
    String? authToken,
  }) async {
    final url = Uri.parse("$baseUrl$endpoint");
    late http.Response response; // Tambahkan deklarasi variabel response di sini

    try {
      if (isPost) {
        response = await http.post(
          url,
          headers: _buildHeaders(headers, authToken),
          body: jsonEncode(body),
        );
      } else {
        response = await http.get(
          url,
          headers: _buildHeaders(headers, authToken),
        );
      }

      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        print('HTTP Request failed with status: ${response.statusCode}');
        print('API Response Body: ${response.body}');
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error during API request: $error');
      if (response != null) {
        print('API Response Body: ${response.body}');
      }
      return null;
    }
  }

  Map<String, String> _buildHeaders(Map<String, String>? headers, String? authToken) {
    final Map<String, String> finalHeaders = headers ?? {};

    if (authToken != null) {
      finalHeaders['Authorization'] = 'Bearer $authToken';
    }

    return finalHeaders;
  }

  // ambil data ke profile page
  Future<dynamic> getProfileData(String path, String authToken) async {
    final url = Uri.parse("$baseUrl/$path");
    final ApiService apiService = ApiService(ApiConfig.baseUrl);

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $authToken'},
    );

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load profile data');
    }
  }
}


