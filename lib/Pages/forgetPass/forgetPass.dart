import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:brand/Pages/Api/api_config.dart';
import 'package:brand/Pages/Api/api_service.dart';
import 'package:brand/Pages/Widgets/text_form_global.dart';
import 'package:brand/Pages/forgetPass/verifScreen.dart';
import 'package:flutter/material.dart';

class forgetPass extends StatefulWidget {
  const forgetPass({super.key});

  @override
  State<forgetPass> createState() => _forgetPassState();
}

class _forgetPassState extends State<forgetPass> {
  final TextEditingController emailController = TextEditingController();
  String email = "";
  final ApiService apiService = ApiService(ApiConfig.baseUrl);

  void _sendemail(BuildContext context) async {
    try {
      final body = {
        'email': emailController.text,
      };

      final response =
          await apiService.fetchData("/sendEmail", body: body, isPost: true);

      print("Response from API: $response");

      if (response['success'] == false) {
        if (response['message'] ==
            ' Account not found, please register first') {
          showErrorMessage(context, 'Register terlebih dahulu');
        } else {
          showErrorMessage(context, 'Gagal mengirim nomer verifikasi');
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        }
      }
      if (response['success'] == true) {
        showSuccessMessage(context, 'Berhasil mengirim nomer verifikasi');

        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => VerificationScreen(
                        email: emailController.text,
                      )));
        });
      }
    } catch (e) {
      print("Error: $e");
      showErrorMessage(context, 'Gagal mengirim nomer verifikasi');
    }
  }

  void showErrorMessage(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.topSlide,
      title: 'gagal',
      desc: message,
    )..show();
  }

  void showSuccessMessage(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.topSlide,
      title: 'Berhasil',
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
        body: Column(
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
                        margin: EdgeInsets.only(top: 100, left: 20, right: 20),
                        height: 197,
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
                            'Please input your email, and we will send your link for setting password',
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
                        Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: TextFormGlobal(
                            controller: emailController,
                            text: 'Email',
                            textInputType: TextInputType.emailAddress,
                            obscure: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 230),
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
                        _sendemail(context);
                      },
                      child: Text(
                        'SEND',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Helvetica Neue',
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }));
  }
}
