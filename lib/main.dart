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
import 'package:helpee/screens/setting.dart';

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

  // int currentIndex = 0;

  // final screens = [
  //   TestHome(),
  //   MyRequest(),
  //   CreateRequest(),
  //   Notificationscreen(),
  //   Profile(),
  // ];

  int currentTab = 0;
  final List<Widget> screens = [
    TestHome(),
    MyRequest(),
    Profile(),
    Setting(),
    CreateRequest()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = TestHome();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Register(),
      home: Scaffold(
        /* ----------------- Body ---------------- */
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = TestHome();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dashboard,
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                                color: currentTab == 0
                                    ? Colors.blue
                                    : Colors.grey),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = MyRequest();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat,
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'My Request',
                            style: TextStyle(
                                color: currentTab == 1
                                    ? Colors.blue
                                    : Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                // Right Tab Bar Icons
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Profile();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                                color: currentTab == 2
                                    ? Colors.blue
                                    : Colors.grey),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Setting();
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            color: currentTab == 3 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Setting',
                            style: TextStyle(
                                color: currentTab == 3
                                    ? Colors.blue
                                    : Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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