import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:brand/Pages/Api/api_config.dart';
import 'package:brand/Pages/Api/api_service.dart';
import 'package:brand/Pages/Api/google_signin_api.dart';
import 'package:brand/Pages/Login/screen.dart';
import 'package:brand/Pages/Profile/screen_google.dart';
import 'package:brand/Pages/Widgets/text_form_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  // const RegisterScreen({Key? key,}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isGoogleSignIn = false;
  bool _isPasswordVisible = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? nameGoogle;

  final ApiService apiService = ApiService(ApiConfig.baseUrl);

  void _navigateToLoginScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // void _registerGoogle(GoogleSignInAccount user) async {
  //   try {
  //     // print('Login dengan Google Berhasil');
  //     // print('Email: ${user.email}');
  //     // print('Nama Tampilan: ${user.displayName}');

  //     final GoogleSignInAuthentication googleAuth = await user.authentication;
  //     final String? accessToken = googleAuth.accessToken;

  //     if (accessToken != null) {
  //       // Simpan token ke SharedPreferences atau proses autentikasi lainnya
  //       final SharedPreferences pref = await SharedPreferences.getInstance();
  //       pref.setString('token', accessToken);
  //       print('Access Token: $accessToken');

  //       // Pindah ke halaman ProfileGoogle setelah token berhasil diperoleh
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ProfileGoogle(googleUser: user),
  //         ),
  //       );
  //     } else {
  //       print('Gagal mendapatkan access token dari Google Sign-In');
  //       showErrorMessage(context, 'Gagal mendapatkan access token dari Google');
  //     }
  //   } catch (error) {
  //     print('Kesalahan selama Login dengan Google: $error');
  //     showErrorMessage(context, 'Terjadi kesalahan selama login dengan Google');
  //     Future.delayed(Duration(seconds: 3), () {
  //       Navigator.of(context).pop();
  //     });
  //   }
  // }

  void _registerGoogle(GoogleSignInAccount user) async {
    try {
      final GoogleSignInAuthentication googleAuth = await user.authentication;
      final String? accessToken = googleAuth.accessToken;

      if (accessToken != null) {
        final apiUrl = 'https://brand.playease.site/api/oauthGoogle';

        final body = {
          'name': user.displayName,
          'email': user.email,
        };

        final Map<String, String> headers = {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        };

        final apiService = ApiService('https://brand.playease.site');
        final apiResponse = await apiService.fetchData(
          '/api/oauthGoogle/${accessToken}',
          body: body,
          isPost: true,
          headers: headers,
          authToken: accessToken,
        );

        if (apiResponse != null) {
          // Proses berhasil
          print('Data berhasil disimpan ke API');
          showSuccessMessage(context, 'Registrasi dengan Google berhasil');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileGoogle(googleUser: user),
            ),
          );
        } else {
          // Proses gagal
          print('Register gagal menyimpan data ke API');
          showErrorMessage(context, 'Gagal menyimpan data ke API');
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
        }
      } else {
        print('Gagal mendapatkan access token dari Google Sign-In');
        showErrorMessage(context, 'Gagal mendapatkan access token dari Google');
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
      }
    } catch (error) {
      print('Kesalahan selama registrasi dengan Google: $error');
      showErrorMessage(
          context, 'Terjadi kesalahan selama registrasi dengan Google');
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    }
  }

  void _registerUser(
      BuildContext context, String name, String email, String password) async {
    try {
      final body = {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      };

      final response = await apiService.fetchData("/api/registration",
          body: body, isPost: true, authToken: '');

      print("Response from API: $response");

      if (response['success'] == true) {
        showSuccessMessage(context, 'Registrasi berhasil');

        Future.delayed(Duration(seconds: 5), () {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      } else {
        showErrorMessage(context, 'Registrasi gagal');
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
      }
    } catch (e) {
      print("Error: $e");
      showErrorMessage(context, 'Registrasi gagal');
      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pop();
      });
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
      title: 'Sukses!',
      desc: 'Harap cek email untuk verifikasi akun',
    )..show();
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
                                          obscure:
                                              !_isPasswordVisible, // Gunakan variabel _isPasswordVisible di sini
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          _isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordVisible =
                                                !_isPasswordVisible; // Tombol "Show Password"
                                          });
                                        },
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
                            width: screenWidth * 0.60,
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
                                    onPressed: () async {
                                      var user = await GoogleSignInApi.login();
                                      if (user != null) {
                                        print("berhasil registrasi");
                                        print(user.displayName);
                                        print(user.email);
                                        print(user.photoUrl);
                                        _registerGoogle(user);
                                      }
                                    },
                                    child: Text(
                                      "Register with Google",
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

  // Future signIn() async {
  //   final user = await GoogleSignInApi.login();
  //   if (user == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Sign in failed'),
  //       ),
  //     );
  //   } else {
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => ProfileScreen()));
  //   }
  // }
}
