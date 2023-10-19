import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:brand/Pages/Api/api_config.dart';
import 'package:brand/Pages/Api/api_service.dart';
import 'package:brand/Pages/Login/screen.dart';
import 'package:brand/Pages/Widgets/text_form_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class newPass extends StatefulWidget {
  newPass({
    super.key,
    required this.token,
  });
  final String token;

  @override
  State<newPass> createState() => _newPassState();
}

class _newPassState extends State<newPass> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final ApiService apiService = ApiService(ApiConfig.baseUrl);
  bool obscureText = true;

  void _forgetPass(BuildContext context) async {
    try {
      final body = {
        'password': passwordController.text,
        'confirm_password': confirmController.text,
      };

      final response = await apiService.fetchData(
          "/forget-password/${widget.token}",
          body: body,
          isPost: true);

      print("Response from API: $response");

      if (response['success'] == false) {
        if (response['message'] ==
            'The confirm password field must match password.') {
          showErrorMessage(context, 'Password tidak sama');
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        } else {
          showErrorMessage(context, 'Akun belum diverifikasi');
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        }
      }
      if (response['success'] == false) {
        if (response['message'] ==
            'The new password cannot be the same as the old one.') {
          showErrorMessage(context, 'Akun belum diverifikasi');
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        } else {
          showErrorMessage(context, 'Gagal ganti password');
        }
      }
      if (response['success'] == true) {
        showSuccessMessage(context, 'Berhasil ganti password');

        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      }
    } catch (e) {
      print("Error: $e");
      showErrorMessage(context, 'Gagal ganti password');
      Future.delayed(Duration(seconds: 2), () {
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
        backgroundColor: Color(0xffF2F5FF),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                          height: 255,
                          width: 363,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 120),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 35,
                              right: 35,
                            ),
                            child: Text(
                              'Pleas input new password and you can login again',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Barlow',
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 160,
                    left: 20,
                    right: 20,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
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
                              obscure:
                                  obscureText, // Menggunakan nilai obscureText
                              textInputType: TextInputType.visiblePassword,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText =
                                    !obscureText; // Toggle nilai obscureText
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
                    top: 220,
                    left: 20,
                    right: 20,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
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
                              controller: confirmController,
                              text: "Confirm Password",
                              obscure:
                                  obscureText, // Menggunakan nilai obscureText
                              textInputType: TextInputType.visiblePassword,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText =
                                    !obscureText; // Toggle nilai obscureText
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
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 285),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF4E6EAF), Color(0xFFA993D3)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {
                          _forgetPass(context);
                        },
                        child: Text(
                          'SAVE',
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
