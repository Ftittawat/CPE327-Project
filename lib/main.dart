import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/components/utils.dart';
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
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      home: Register(),
      // home: Scaffold(
      //   body: screens[currentIndex],
      //   bottomNavigationBar: BottomNavigationBar(
      //     currentIndex: currentIndex,
      //     onTap: (index) => setState(() => currentIndex = index),
      //     type: BottomNavigationBarType.fixed,
      //     showSelectedLabels: false,
      //     showUnselectedLabels: false,
      //     selectedFontSize: 16.0,
      //     unselectedFontSize: 12.0,
      //     iconSize: 25,
      //     selectedIconTheme: IconThemeData(color: Color(0xFF005792), size: 27),
      //     selectedItemColor: Color(0xFF005792),
      //     unselectedItemColor: Colors.grey.shade600,
      //     backgroundColor: Colors.grey.shade200,
      //     items: const <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: 'Home',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.wysiwyg),
      //         label: 'Ask for help',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.add_circle),
      //         label: 'Add',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.notifications),
      //         label: 'Notification',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Profile',
      //       ),
      //     ],
      //   ),
      // ),
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