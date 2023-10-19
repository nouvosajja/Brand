import 'dart:convert';
import 'package:brand/Pages/Login/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brand/Pages/Api/api_config.dart';
import 'package:brand/Pages/Api/api_service.dart';
import 'package:brand/Pages/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name;
  bool isLoading = false;
  UserModel? user;
  final ApiService apiService = ApiService(ApiConfig.baseUrl);

  @override
  void initState() {
    _fetchUserData();
    _fetchUserData().then((value) {
      setState(() {
        user = value;
      });
    });
    super.initState();
  }

  Future _fetchUserData() async {
    final Uri url = Uri.parse(ApiConfig.baseUrl + "/profile");

    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    String? savedName = pref.getString('name');

    setState(() {
      name = savedName;
    });

    print('token : $token');

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.body);
      print('status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        print(responseBody['success']);
        print(responseBody['success'].runtimeType);
        if (responseBody['success']) {
          setState(() {
            user = UserModel.fromJson(responseBody);
            name = user?.data?.name;
            print(responseBody['data']);
          });
        } else {
          throw Exception("Failed to fetch data from API");
        }
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F5FF),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/BG3.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 100, left: 20, right: 20),
                            height: 197,
                            width: 363,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            Container(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage('assets/images/PP.png'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                'Welcome Back',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Barlow',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff506EAF),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                name ?? 'Data tidak ada',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Barlow',
                                  color: Color(0xff506EAF),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF4E6EAF),
                                    Color(0xFFA993D3)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString("token", "");
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'LOG OUT',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Helvetica Neue',
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ]));
  }
}
