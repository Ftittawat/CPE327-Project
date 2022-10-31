import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/screens/createrequest.dart';
import 'package:helpee/screens/getstart.dart';
import 'package:helpee/screens/home.dart';
import 'package:helpee/screens/login.dart';
import 'package:helpee/screens/register.dart';
import 'package:helpee/screens/test-listview.dart';
import 'package:helpee/screens/my-request.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyRequest(),
    );
  }
}

// Image.asset("assets/images/helpee1.png"),
// Text("Welcome to helpee", style: GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.w700, color: Color(0xFFFFFFFF))),
// Text("Application for help in various fields", style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF)))