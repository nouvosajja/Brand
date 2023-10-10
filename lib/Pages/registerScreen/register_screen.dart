import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final screenHeight = constraints.maxHeight;
        final screenWidth = constraints.maxWidth;

        return Stack(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
              child: SvgPicture.asset(
                'assets/images/BG2.svg',
                fit: BoxFit.cover,
              ),
            ),
            // BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            //   child: Container(
            //     color: Colors.black.withOpacity(0.2),
            //     width: screenWidth,
            //     height: screenHeight,
            //   ),
            // ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SvgPicture.asset(
                  //   'assets/images/Logo.svg',
                  //   height: screenHeight * 0.2,
                  // ),
                  // SizedBox(height: screenHeight * 0.03),
                  // Text(
                  //   'Brand',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: screenHeight * 0.04,
                  //     fontWeight: FontWeight.bold,
                  //     decoration: TextDecoration.none,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
