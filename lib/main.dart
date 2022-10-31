import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/screens/createrequest.dart';
import 'package:helpee/screens/getstart.dart';
import 'package:helpee/screens/home.dart';
import 'package:helpee/screens/login.dart';
import 'package:helpee/screens/profile.dart';
import 'package:helpee/screens/register.dart';
import 'package:helpee/screens/createrequest.dart';
import 'package:helpee/screens/notification.dart';
import 'package:helpee/screens/allRequest.dart';
import 'package:helpee/screens/myRequest.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget createrequestIcon() {
    return SizedBox(
        child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: Color(0xFF005792)),
    ));
  }

  int currentIndex = 0;

  final screens = [
    TestHome(),
    MyRequest(),
    CreateRequest(),
    Notificationscreen(),
    Profile(),
  ];

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

// @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TestHome(),
//     );
//   }