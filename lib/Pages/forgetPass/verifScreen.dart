import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:brand/Pages/Api/api_config.dart';
import 'package:brand/Pages/Api/api_service.dart';
import 'package:brand/Pages/forgetPass/newPass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({
    super.key, required this.email,
  });
  final String email;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController tokenController = TextEditingController();
  final ApiService apiService = ApiService(ApiConfig.baseUrl);
  int countdown = 60;
  Stream<int> countdownStream =
      Stream.periodic(Duration(seconds: 1), (i) => 60 - i);
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  bool canPressSend = false;
  StreamSubscription<int>? countdownSubscription;

  @override
  void initState() {
    super.initState();
    countdownSubscription = countdownStream.listen((int seconds) {
      setState(() {
        countdown = seconds;
        if (countdown == 0) {
          canPressSend = true;
          countdownSubscription?.cancel();
          _resendToken(context);
        }
      });
    });
  }

  void startCountdownAgain() {
    countdownSubscription?.cancel();
    countdownStream = Stream.periodic(Duration(seconds: 1), (i) => 60 - i);
    countdownSubscription = countdownStream.listen((int seconds) {
      setState(() {
        countdown = seconds;
        if (countdown == 0) {
          canPressSend = true;
          countdownSubscription?.cancel();
        }
      });
    });
    canPressSend = false;
  }

  @override
  void dispose() {
    countdownSubscription?.cancel(); // Membatalkan langganan jika ada
    for (var node in controllers) {
      node.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

void _resendToken(BuildContext context) async {
  final dynamic responseData = await apiService.fetchData("/resendToken/${widget.email}", isPost: true);
  print("Response from API: $responseData");

  if (responseData is Map<String, dynamic>) {
    if (responseData['success'] == true) {
      showSuccessMessage(context, responseData['message']);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    } else {
      showErrorMessage(context, 'Gagal mengirim ulang token');
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
    }
  } else {
    showErrorMessage(context, 'Gagal mengirim ulang token');
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }
}
 

  void _checkToken(BuildContext context) async {
    try {
      final token = controllers.map((controller) => controller.text).join();

      final body = {
        'token' : token,
      };

      final response =
          await apiService.fetchData("/checkToken", body: body, isPost: true);

      print("Response from API: $response");

      if (response['success'] == false) {
        if (response['message'] == 'The account has not been verified') {
          showErrorMessage(context, 'Akun belum diverifikasi');
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        } else {
          showErrorMessage(context, 'Kata sandi salah');
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        }
      }
      if (response['success'] == true) {
        showSuccessMessage(context, 'Berhasil mengirim token');
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => newPass(token: token)));
        });
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Send akun gagal"),
        duration: Duration(seconds: 2),
      ));
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

      return Scaffold(
        backgroundColor: Color(0xffF2F5FF),
        body: Center(
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
                          height: 290,
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
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'Anda harus memverifikasi alamat email anda\n',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Barlow',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${widget.email}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Barlow',
                                      fontWeight:
                                          FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 160),
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          return Row(
                            children: [
                              SizedBox(
                                width: 40,
                                child: TextField(
                                  controller: controllers[index],
                                  focusNode: focusNodes[index],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      if (index < 3) {
                                        FocusScope.of(context).requestFocus(
                                            focusNodes[index + 1]);
                                      } else {
                                        // Ini adalah kotak input terakhir
                                        // Anda bisa mengimplementasikan logika di sini
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                  width:
                                      30), // Tambahkan ini untuk ruang antara kotak input
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 240),
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
                          if (canPressSend) {
                            setState(() {
                              countdown = 60;
                              canPressSend = false;
                            });
                            startCountdownAgain();
                          }
                        },
                        child: Text(
                          'Kirim ulang',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Helvetica Neue',
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 290),
                      child: Text(
                        "${countdown ~/ 60}:${(countdown % 60).toString().padLeft(2, '0')}",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 320),
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
                          _checkToken(context);
                        },
                        child: Text(
                          'Lanjut',
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
