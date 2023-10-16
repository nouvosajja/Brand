import 'package:brand/Pages/Api/api_config.dart';
import 'package:brand/Pages/Api/api_service.dart';
import 'package:brand/Pages/Login/screen.dart';
import 'package:brand/Pages/Widgets/text_form_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ApiService apiService = ApiService(ApiConfig.baseUrl);

  void _navigateToLoginScreen() { 
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _registerUser(
      BuildContext context, String name, String email, String password) async {
    try {
      final body = {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      };

      final response =
          await apiService.fetchData("/registration", body: body, isPost: true);

      print("Response from API: $response");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Registrasi berhasil"),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Registrasi gagal"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: LayoutBuilder(
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
                            height: screenHeight * 0.050,
                          ),
                          Center(
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 32,
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
                                height: screenHeight * 0.65,
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
                                top: screenHeight * 0.3,
                                left: 0,
                                right: 0,
                                child: Text(
                                  "Register to use this amazing app",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: screenHeight * 0.33,
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
                                      Icon(
                                        Icons.person_outline_rounded,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: TextFormGlobal(
                                          controller: nameController,
                                          text: "Name",
                                          textInputType: TextInputType.name,
                                          obscure: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(10),
                              Positioned(
                                top: screenHeight * 0.405,
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
                                          textInputType:
                                              TextInputType.emailAddress,
                                          obscure: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Positioned(
                                top: screenHeight * 0.480,
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
                                          obscure: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(5),
                              Positioned(
                                top: screenHeight * 0.565,
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
                                      _registerUser(
                                          context,
                                          nameController.text,
                                          emailController.text,
                                          passwordController.text);
                                    },
                                    child: Text(
                                      "REGISTER",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'HelveticaNeue',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Positioned(
                            top: screenHeight * 0.67,
                            left: 0,
                            right: 0,
                            child: Row(
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
                                    fontSize: 16,
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
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: screenWidth * 0.625,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                                elevation: MaterialStateProperty.all<double>(0),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/google.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Register with Google',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Barlow'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Positioned(
                            top: screenHeight * 0.72,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Have an account?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Barlow',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _navigateToLoginScreen();
                                  },
                                  child: Text(
                                    "Login here",
                                    style: TextStyle(
                                      color: Color(0xFFBC53FF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Barlow',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
