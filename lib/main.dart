import 'package:brand/Pages/Profile/screen.dart';
import 'package:brand/Pages/forgetPass/forgetPass.dart';
import 'package:brand/Pages/forgetPass/newPass.dart';
import 'package:brand/Pages/registerScreen/register_screen.dart';
import 'package:brand/Pages/splash_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: newPass(),
    );
  }
}
