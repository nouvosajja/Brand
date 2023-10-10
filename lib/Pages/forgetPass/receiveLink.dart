import 'package:flutter/material.dart';

class recLink extends StatefulWidget {
  const recLink({super.key});

  @override
  State<recLink> createState() => _recLinkState();
}

class _recLinkState extends State<recLink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
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
                          'ini adalah link untuk setting password setelah klik link maka akan lari ke setting ulang password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Barlow',
                            fontWeight: FontWeight.w500,
                            color: Color(0xff0000FF),
                          ),
                        ),
                      ),
                    ],
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