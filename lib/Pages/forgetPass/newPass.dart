import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class newPass extends StatefulWidget {
  const newPass({super.key});

  @override
  State<newPass> createState() => _newPassState();
}

class _newPassState extends State<newPass> {
  bool _isPasswordVisible = false;

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
                      color: Colors.white.withOpacity(
                          0.3), // Latar belakang warna abu-abu blur
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey, // Warna border
                        width: 1.0, // Lebar border
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
                          child: TextField(
                            obscureText:
                                !_isPasswordVisible, // Menyembunyikan atau menampilkan teks input
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
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
                      color: Colors.white.withOpacity(
                          0.3), // Latar belakang warna abu-abu blur
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey, // Warna border
                        width: 1.0, // Lebar border
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
                          child: TextField(
                            obscureText:
                                !_isPasswordVisible, // Menyembunyikan atau menampilkan teks input
                            decoration: InputDecoration(
                              hintText: "Repeat Password",
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 295, left: 80),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4E6EAF), Color(0xFFA993D3)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {},
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 10),
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
