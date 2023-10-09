import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SvgPicture.asset('assets/images/BG1.svg'),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                SvgPicture.asset('assets/images/Logo.svg'),
                Text('Brand', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold))
          ]),
        ),
      )
    ]);
  }
}
