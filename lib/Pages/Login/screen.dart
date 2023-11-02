import 'dart:convert';
import 'dart:html';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:brand/Pages/Api/api_config.dart';
import 'package:brand/Pages/Api/api_service.dart';
import 'package:brand/Pages/Profile/screen.dart';
import 'package:brand/Pages/Profile/screen_google.dart';
import 'package:brand/Pages/Widgets/text_form_global.dart';
import 'package:brand/Pages/forgetPass/forgetPass.dart';
import 'package:brand/Pages/registerScreen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  // final GoogleSignInAccount user;

  // LoginScreen({
  //   Key? key,
  //   required this.user,
  // }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isGoogleSignIn = false;
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

  void _loginGoogle() async {
    var url =
        'https://brand.playease.site/api/google'; // Gantilah dengan URL otentikasi OAuth 2.0 Anda

    try {
      if (await launch(url)) {
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      showErrorMessage(
          context, 'Terjadi kesalahan saat membuka URL otentikasi');
      return;
    }
  }

  // void _loginGoogle() async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  //   if (googleUser != null) {
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //     final String? accessToken =
  //         googleAuth.accessToken; // Token dari Google Sign-In
  //     _handleToken(
  //         accessToken!); // Here you must ensure that accessToken is not null
  //   } else {
  //     return;
  //   }
  // }

  // void _loginGoogle() async {
  //   try {
  //     final response =
  //         await _callGoogleAPI(); // Panggil metode untuk menghubungi API Google Anda
  //     if (response != null) {
  //       _handleToken(response['token']); // Handle token dari respons API
  //     }
  //   } catch (e) {
  //     print("Error during Google login: $e");
  //     showErrorMessage(context, 'Login gagal');
  //     Future.delayed(Duration(seconds: 3), () {
  //       Navigator.of(context).pop();
  //     });
  //   }
  // }

  // Future<Map<String, dynamic>?> _callGoogleAPI() async {
  //   var url = 'https://brand.playease.site/google';
  //   try {
  //     // final url =
  //     //     'https://accounts.google.com/o/oauth2/auth?client_id=329073525441-5r4mlijv8033shl9i3snpegre9kk8nk8.apps.googleusercontent.com&redirect_uri=https%3A%2F%2Fbrand.playease.site%2Fapi%2Fgoogle%2Fcallback&scope=openid+profile+email&response_type=code'; // Ganti dengan URL backend yang sesuai
  //     // final result = await http.get(Uri.parse(url));

  //     //   if (result.statusCode == 200) {
  //     //     return json.decode(
  //     //         result.body); // Respons API yang berisi token atau data relevan
  //     //   } else {
  //     //     throw 'Failed to fetch data';
  //     //   }
  //     // } catch (e) {
  //     //   throw 'Error calling Google API: $e';
  //     // }
  //     if (await launch(url)) {
  //       _handleToken;
  //     } else {
  //       throw 'Could not launch $url';
  //     }
  //   } catch (e) {
  //     print('Error launching URL: $e');
  //     showErrorMessage(
  //         context, 'Terjadi kesalahan saat membuka URL otentikasi');
  //   }
  // }

  // void _handleToken(String token) async {
  //   // Disimpan token ke Shared Preferences atau proses autentikasi lainnya
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString('token', token);

  //   // Kembali ke aplikasi setelah token berhasil diperoleh
  //   _handleReturningFromGoogleAuth();
  // }

  // void _handleReturningFromGoogleAuth() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? token = pref.getString('token');

  //   if (token != null && token.isNotEmpty) {
  //     // Jika token tersedia, lanjutkan ke halaman ProfileGoogle
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => ProfileGoogle()),
  //     );
  //   } else {
  //     // Jika token tidak tersedia, tampilkan pesan error
  //     showErrorMessage(context, 'Token not found');
  //   }
  // }

  Future<void> _loginUser(
      BuildContext context, String email, String password) async {
    try {
      final body = {
        'email': emailController.text,
        'password': passwordController.text,
      };

      final response =
          await apiService.fetchData("/api/login", body: body, isPost: true);

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
        final userName = response['data']['name'];

        if (token != null && token is String) {
          final SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('token', token);
          pref.setString('name', userName);

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

  // Future<void> _loginGoogle(
  //   BuildContext context,
  // ) async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     if (googleUser == null) {
  //       // User membatalkan proses login Google.
  //       return;
  //     }

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //     final String? accessToken = googleAuth.accessToken;

  //     final response = await http.get(
  //       Uri.parse('https://brand.playease.site/google'),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       print("Login berhasil: ${response.body}");
  //     } else {
  //       showErrorMessage(context, 'Login gagal');
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //     showErrorMessage(context, 'Login gagal');
  //     Future.delayed(Duration(seconds: 3), () {
  //       Navigator.of(context).pop();
  //     });
  //   }
  // }

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
                                      obscure: obscureText,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText = !obscureText;
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
                                onPressed: () {
                                  // var user = await GoogleSignInApi.login();
                                  // if (user != null) {
                                  //   print("berhasil");
                                  //   print(user.displayName);
                                  //   print(user.email);
                                  //   print(user.photoUrl);
                                  //   Navigator.push(context,
                                  //       MaterialPageRoute(builder: (context)=>ProfileGoogle(googleUser: user)));
                                  // }
                                  _loginGoogle();
                                },
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
