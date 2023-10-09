import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        height: screenHeight * 0.13,
                      ),
                      Center(
                        child: Text(
                          "Welcome Back",
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
                            height: screenHeight * 0.59,
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
                            top: screenHeight *
                                0.02, // Mengatur posisi logo ke tengah secara vertikal
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
                            top: screenHeight *
                                0.159, // Mengatur posisi teks di bawah SVG
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
                            top: screenHeight *
                                0.3, // Mengatur posisi teks di bawah SVG
                            left: 0,
                            right: 0,
                            child: Text(
                              "Please Login to Continue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black, // Warna teks
                                fontSize: 14, // Ukuran teks
                              ),
                            ),
                          ),
                          Positioned(
                            top: screenHeight *
                                0.33, // Mengatur posisi TextField
                            left: 0,
                            right: 0,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 24),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(
                                    0.3), // Latar belakang warna abu-abu blur
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.email, // Ikon email
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                        hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 14,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: screenHeight *
                                0.405, // Mengatur posisi TextField
                            left: 0,
                            right: 0,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 24),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(
                                    0.3), // Latar belakang warna abu-abu blur
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.lock_outline_rounded, // Ikon email
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                        hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 14,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // make button with positioned
                          Positioned(
                            top: screenHeight *
                                0.5, // Mengatur posisi tombol login
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
                                  ], // Ubah warna gradient sesuai preferensi Anda
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "LOG IN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }));
  }
}
