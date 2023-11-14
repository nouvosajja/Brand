import 'dart:convert';
import 'package:brand/Pages/Api/google_signin_api.dart';
import 'package:brand/Pages/Login/screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brand/Pages/Api/api_config.dart';
import 'package:brand/Pages/Api/api_service.dart';
import 'package:brand/Pages/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileGoogle extends StatefulWidget {
  final GoogleSignInAccount? googleUser;
  const ProfileGoogle({
    Key? key,
    this.googleUser,
  }) : super(key: key);

  @override
  State<ProfileGoogle> createState() => _ProfileGoogleState();
}

class _ProfileGoogleState extends State<ProfileGoogle> {
  String? name;
  bool isLoading = false;
  UserModel? user;
  String? nameGoogle;
  String? photoGoogle;

  void fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final GoogleSignInAuthentication googleAuth =
          await widget.googleUser!.authentication;
      final String? accessToken = googleAuth.accessToken;

      if (accessToken != null) {
        final apiService = ApiService('https://brand.playease.site');
        final data = await apiService.getProfileData('profile', accessToken);

        // Gunakan data sesuai kebutuhan
        // Contoh: Ambil 'name' dari data
        setState(() {
          name = data['name'];
        });
      }
    } catch (error) {
      print('Error fetching profile data: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameGoogle = widget.googleUser?.displayName;
    photoGoogle = widget.googleUser?.photoUrl;
    fetchData();
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
                                      // AssetImage('assets/images/PP.png'),
                                      NetworkImage(photoGoogle!)),
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
                                name ?? nameGoogle ?? 'Data kosong',
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
                                  // final SharedPreferences prefs =
                                  //     await SharedPreferences.getInstance();
                                  // prefs.setString("id", "");
                                  await GoogleSignInApi.logout();
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
