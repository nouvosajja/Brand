import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F5FF),
        body: Column(children: [
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
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/PP.png'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Barlow',
                            fontWeight: FontWeight.w500,
                            color: Color(0xff506EAF),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        child: Text(
                          'Jessica W',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Barlow',
                            color: Color(0xff506EAF),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
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
                            'LOG OUT',
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ]));
  }
}
