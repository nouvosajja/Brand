import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class forgetPass extends StatefulWidget {
  const forgetPass({super.key});

  @override
  State<forgetPass> createState() => _forgetPassState();
}

class _forgetPassState extends State<forgetPass> {
  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.only(
                      top: 120),
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
                    color: Colors.white
                        .withOpacity(0.3), // Latar belakang warna abu-abu blur
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.grey, // Warna border
                      width: 1.0, // Lebar border
                    ),
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
              Container(
                margin: EdgeInsets.only(top: 230, left: 80),
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
            ],
          ),
        ],
      ),
    );
  }
}
