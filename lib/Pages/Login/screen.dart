import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:brand/Pages/Api/api_config.dart';
import 'package:brand/Pages/Api/api_service.dart';
import 'package:brand/Pages/Profile/screen.dart';
import 'package:brand/Pages/Widgets/text_form_global.dart';
import 'package:brand/Pages/forgetPass/forgetPass.dart';
import 'package:brand/Pages/registerScreen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ApiService apiService = ApiService(ApiConfig.baseUrl);

  void _navigateToRegisterScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }
  void _navigateToForgetPass() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => forgetPass()),
    );
  }
  void _loginUser(BuildContext context, String email, String password) async {

    try {
      final body = {
        'email': emailController.text,
        'password': passwordController.text,
      };

      final response =
          await apiService.fetchData("/login", body: body, isPost: true);

      print("Response from API: $response");

      if (response['success'] == false) {
        if (response['message'] == 'The account has not been verified') {
          showErrorMessage(context, 'Akun belum diverifikasi');
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        }
      }
       if (response['success'] == false) {
        if (response['message'] == 'Account not found, please register first') {
          showErrorMessage(context, 'Akun Tidak Ditemukan'); 
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        }
      }
      if (response['success'] == false) {
        if (response['message'] == 'The password you entered is incorrect') {
          showErrorMessage(context, 'Password salah'); 
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        }
      }
      if (response['success'] == true) {
        final token = response['data']['token'];

        if (token != null && token is String) {
          final SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('token', token);

          showSuccessMessage(context, 'Login berhasil');

          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          });
        } else {
          showErrorMessage(context, 'Login gagal');
        }
      }
    } catch (e) {
      print("Error: $e");
      showErrorMessage(context, 'Login gagal');
    }
  }

  void showErrorMessage(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.topSlide,
      title: 'Gagal',
      desc: message,
    )..show();
  }

  void showSuccessMessage(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.topSlide,
      title: 'Selamat!',
      desc: message,
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      FocusManager.instance.primaryFocus?.unfocus();
    }, child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final screenHeight = constraints.maxHeight;
      final screenWidth = constraints.maxWidth;

      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: screenWidth,
                    height: screenHeight,
                    child: SvgPicture.asset(
                      'assets/images/BG2.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.1,
                      ),
                      Center(
                        child: Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontFamily: 'Barlow',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF506EAF),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: screenWidth * 0.85,
                            height: screenHeight * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: screenHeight * 0.02,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Transform.scale(
                                scale: 1,
                                child: SvgPicture.asset(
                                  'assets/images/Logo.svg',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: screenHeight * 0.159,
                            left: 0,
                            right: 0,
                            child: Text(
                              "BRAND",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF506EAF),
                                fontSize: 46,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Barlow',
                              ),
                            ),
                          ),
                          Positioned(
                            top: screenHeight * 0.28,
                            left: 0,
                            right: 0,
                            child: Text(
                              "Please Login to Continue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Positioned(
                            top: screenHeight * 0.31,
                            left: 0,
                            right: 0,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 24),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/Mail.svg',
                                    width: 15,
                                    height: 15,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: TextFormGlobal(
                                      controller: emailController,
                                      text: "Email",
                                      textInputType: TextInputType.emailAddress,
                                      obscure: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: screenHeight * 0.386,
                            left: 0,
                            right: 0,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 24),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/Lock.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: TextFormGlobal(
                                      controller: passwordController,
                                      text: "Password",
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      obscure:
                                          obscureText, // Gunakan nilai obscureText
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText =
                                            !obscureText; // Saat tombol ditekan, ubah nilai obscureText
                                      });
                                    },
                                    icon: Icon(
                                      obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: screenHeight * 0.46,
                            left: 0,
                            right: 0,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 24),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF4E6EAF),
                                    Color(0xFFA993D3)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  _loginUser(context, emailController.text,
                                      passwordController.text);
                                },
                                child: Text(
                                  "LOG IN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'HelveticaNeue',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: screenHeight * 0.52,
                            left: 0,
                            right: 0,
                            child: TextButton(
                              onPressed: () {
                                _navigateToForgetPass();
                              },
                              child: Text(
                                "Forgotten your password?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Barlow',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth * 0.4,
                            height: 1,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Or",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Barlow',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: screenWidth * 0.4,
                            height: 1,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Container(
                        width: screenWidth * 0.55,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/google.png',
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Login with Google",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Barlow',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Barlow',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _navigateToRegisterScreen();
                            },
                            child: Text(
                              "Register Here",
                              style: TextStyle(
                                color: Color(0xFFBC53FF),
                                fontSize: 14,
                                fontFamily: 'Barlow',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }));
  }
}
