import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/components/utils.dart';
import 'package:helpee/screens/createrequest.dart';
import 'package:helpee/screens/getstart.dart';
import 'package:helpee/screens/home.dart';
import 'package:helpee/screens/login.dart';
import 'package:helpee/screens/loginwithgoogle.dart';
import 'package:helpee/screens/profile.dart';
import 'package:helpee/screens/register.dart';
import 'package:helpee/screens/notification.dart';
import 'package:helpee/screens/allRequest.dart';
import 'package:helpee/screens/myRequest.dart';
import 'package:firebase_core/firebase_core.dart';

var loginKey = 0;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        print("Event = $event");
        loginKey = 1;
      } else {
        print("Please Login first");
        loginKey = 0;
      }
      runApp(MyApp());
    });
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("--- ### Main ### ---");
    loginCheck();
  }

  Future<Null> loginCheck() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user == null) {
          print('User is currently signed out!');
          loginKey = 0;
        } else {
          print('User is signed in! ${user.displayName}');
          loginKey = 1;
        }
        print(loginKey != null ? '==> LoginKey : $loginKey' : "Empty");
      });
    });
  }

  Widget createrequestIcon() {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Color(0xFF005792)),
      ),
    );
  }

  int currentIndex = 0;
  int currentTab = 0;

  final screens = [
    TestHome(),
    MyRequest(),
    CreateRequest(),
    Notificationscreen(),
    Profile(),
  ];

  final List<Widget> screens2 = [
    TestHome(),
    MyRequest(),
    Notificationscreen(),
    Profile(),
    LoginWithGoogle(),
  ];

  Widget home1() {
    return MaterialApp(
      // home: Register(),
      home: Scaffold(
        /* ----------------- Body ---------------- */
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF005792),
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              currentScreen = CreateRequest();
              currentTab = 5;
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey.shade200,
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
                      minWidth: 80,
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
                            Icons.home,
                            size: 28,
                            color: currentTab == 0
                                ? Color(0xFF005792)
                                : Colors.grey.shade600,
                          ),
                          // Text(
                          //   'Home',
                          //   style: TextStyle(
                          //       color: currentTab == 0
                          //           ? Color(0xFF005792)
                          //           : Colors.grey.shade600),
                          // )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
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
                            Icons.wysiwyg,
                            size: 28,
                            color: currentTab == 1
                                ? Color(0xFF005792)
                                : Colors.grey.shade600,
                          ),
                          // Text(
                          //   'My Request',
                          //   style: TextStyle(
                          //       color: currentTab == 1
                          //           ? Color(0xFF005792)
                          //           : Colors.grey.shade600),
                          // )
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
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          currentScreen = Notificationscreen();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications,
                            size: 28,
                            color: currentTab == 2
                                ? Color(0xFF005792)
                                : Colors.grey.shade600,
                          ),
                          // Text(
                          //   'Notification',
                          //   style: TextStyle(
                          //       color: currentTab == 2
                          //           ? Color(0xFF005792)
                          //           : Colors.grey.shade600),
                          // )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          currentScreen = Profile();
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            size: 28,
                            color: currentTab == 3
                                ? Color(0xFF005792)
                                : Colors.grey.shade600,
                          ),
                          // Text(
                          //   'Profile',
                          //   style: TextStyle(
                          //       color: currentTab == 3
                          //           ? Color(0xFF005792)
                          //           : Colors.grey.shade600),
                          // )
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

  Widget home2() {
    return MaterialApp(
      // home: Register(),
      home: Scaffold(
        /* ----------------- Body ---------------- */
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 146, 0, 0),
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              currentScreen = CreateRequest();
              currentTab = 5;
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey.shade200,
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
                      minWidth: 80,
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
                            Icons.home,
                            size: 28,
                            color: currentTab == 0
                                ? Color.fromARGB(255, 146, 0, 0)
                                : Colors.grey.shade600,
                          ),
                          // Text(
                          //   'Home',
                          //   style: TextStyle(
                          //       color: currentTab == 0
                          //           ? Color(0xFF005792)
                          //           : Colors.grey.shade600),
                          // )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          currentScreen = LoginWithGoogle();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wysiwyg,
                            size: 28,
                            color: currentTab == 1
                                ? Color.fromARGB(255, 146, 0, 0)
                                : Colors.grey.shade600,
                          ),
                          // Text(
                          //   'My Request',
                          //   style: TextStyle(
                          //       color: currentTab == 1
                          //           ? Color(0xFF005792)
                          //           : Colors.grey.shade600),
                          // )
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
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          currentScreen = Notificationscreen();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications,
                            size: 28,
                            color: currentTab == 2
                                ? Color.fromARGB(255, 146, 0, 0)
                                : Colors.grey.shade600,
                          ),
                          // Text(
                          //   'Notification',
                          //   style: TextStyle(
                          //       color: currentTab == 2
                          //           ? Color(0xFF005792)
                          //           : Colors.grey.shade600),
                          // )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          currentScreen = Profile();
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            size: 28,
                            color: currentTab == 3
                                ? Color.fromARGB(255, 146, 0, 0)
                                : Colors.grey.shade600,
                          ),
                          // Text(
                          //   'Profile',
                          //   style: TextStyle(
                          //       color: currentTab == 3
                          //           ? Color(0xFF005792)
                          //           : Colors.grey.shade600),
                          // )
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

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = TestHome();

  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    // return home1();
    if (loginKey == 0) {
      return home2();
    } else {
      return home1();
    }
    // return MaterialApp(
    //   // home: Register(),
    //   home: Scaffold(
    //     /* ----------------- Body ---------------- */
    //     body: PageStorage(
    //       bucket: bucket,
    //       child: currentScreen,
    //     ),
    //     floatingActionButton: FloatingActionButton(
    //       backgroundColor: Color(0xFF005792),
    //       child: Icon(Icons.add),
    //       onPressed: () {
    //         setState(() {
    //           currentScreen = CreateRequest();
    //           currentTab = 5;
    //         });
    //       },
    //     ),
    //     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    //     bottomNavigationBar: BottomAppBar(
    //       color: Colors.grey.shade200,
    //       shape: CircularNotchedRectangle(),
    //       notchMargin: 10,
    //       child: Container(
    //         height: 60,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             Row(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 MaterialButton(
    //                   minWidth: 80,
    //                   onPressed: () {
    //                     setState(() {
    //                       currentScreen = TestHome();
    //                       currentTab = 0;
    //                     });
    //                   },
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Icon(
    //                         Icons.home,
    //                         size: 28,
    //                         color: currentTab == 0
    //                             ? Color(0xFF005792)
    //                             : Colors.grey.shade600,
    //                       ),
    //                       // Text(
    //                       //   'Home',
    //                       //   style: TextStyle(
    //                       //       color: currentTab == 0
    //                       //           ? Color(0xFF005792)
    //                       //           : Colors.grey.shade600),
    //                       // )
    //                     ],
    //                   ),
    //                 ),
    //                 MaterialButton(
    //                   minWidth: 80,
    //                   onPressed: () {
    //                     setState(() {
    //                       currentScreen = MyRequest();
    //                       currentTab = 1;
    //                     });
    //                   },
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Icon(
    //                         Icons.wysiwyg,
    //                         size: 28,
    //                         color: currentTab == 1
    //                             ? Color(0xFF005792)
    //                             : Colors.grey.shade600,
    //                       ),
    //                       // Text(
    //                       //   'My Request',
    //                       //   style: TextStyle(
    //                       //       color: currentTab == 1
    //                       //           ? Color(0xFF005792)
    //                       //           : Colors.grey.shade600),
    //                       // )
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             // Right Tab Bar Icons
    //             Row(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 MaterialButton(
    //                   minWidth: 80,
    //                   onPressed: () {
    //                     setState(() {
    //                       currentScreen = Notificationscreen();
    //                       currentTab = 2;
    //                     });
    //                   },
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Icon(
    //                         Icons.notifications,
    //                         size: 28,
    //                         color: currentTab == 2
    //                             ? Color(0xFF005792)
    //                             : Colors.grey.shade600,
    //                       ),
    //                       // Text(
    //                       //   'Notification',
    //                       //   style: TextStyle(
    //                       //       color: currentTab == 2
    //                       //           ? Color(0xFF005792)
    //                       //           : Colors.grey.shade600),
    //                       // )
    //                     ],
    //                   ),
    //                 ),
    //                 MaterialButton(
    //                   minWidth: 80,
    //                   onPressed: () {
    //                     setState(() {
    //                       currentScreen = Profile();
    //                       currentTab = 3;
    //                     });
    //                   },
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Icon(
    //                         Icons.person,
    //                         size: 28,
    //                         color: currentTab == 3
    //                             ? Color(0xFF005792)
    //                             : Colors.grey.shade600,
    //                       ),
    //                       // Text(
    //                       //   'Profile',
    //                       //   style: TextStyle(
    //                       //       color: currentTab == 3
    //                       //           ? Color(0xFF005792)
    //                       //           : Colors.grey.shade600),
    //                       // )
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
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