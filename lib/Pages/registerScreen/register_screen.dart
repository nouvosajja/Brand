import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
                                "Register to use this amazing app",
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
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                            Gap(10),
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
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                            SizedBox(
                              width: 12,
                            ),
                            Positioned(
                              top: screenHeight *
                                  0.480, // Mengatur posisi TextField
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
                                          hintText: "Repeat Password",
                                          hintStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                                    ], // Ubah warna gradient sesuai preferensi Anda
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextButton(
                                  onPressed: () {},
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
                                "or",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     // SvgPicture.asset(
                        //     //   'assets/images/Google.svg',
                        //     //   height: 20,
                        //     // ),
                        //     // SizedBox(
                        //     //     width: 5), // Berikan jarak antara ikon dan teks
                        //     // Text(
                        //     //   "Register with Google",
                        //     //   style: TextStyle(
                        //     //     fontSize:
                        //     //         14, // Sesuaikan ukuran teks yang diinginkan
                        //     //     fontWeight: FontWeight.bold,
                        //     //   ),
                        //     // ),

                        //   ],
                        // ),
                        Container(
                          width: screenWidth * 0.6,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              elevation: MaterialStateProperty.all<double>(0),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
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
                                  'assets/images/google.png', // Ganti dengan path gambar Google Anda
                                  height: 20, // Sesuaikan tinggi gambar
                                  width: 20, // Sesuaikan lebar gambar
                                ),
                                SizedBox(
                                    width:
                                        10), // Berikan jarak antara ikon dan teks
                                Text(
                                  'Register with Google',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        14, // Sesuaikan ukuran teks yang diinginkan
                                  ),
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
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Login here",
                                  style: TextStyle(
                                    color: Color(0xFFBC53FF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
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
    );
  }
}
