import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/components/utils.dart';
import 'package:helpee/pages/allRequestPage.dart';
import 'package:helpee/pages/createRequestPage.dart';
import 'package:helpee/pages/profilePage.dart';
import 'package:helpee/pages/userRequestHistoryPage.dart';
import 'package:helpee/pages/userRequestPage.dart';
import 'package:helpee/screens/loginwithgoogle.dart';
import 'package:helpee/screens/pleaselogin.dart';
import 'package:firebase_core/firebase_core.dart';

var loginKey = 0;
var checkKey;

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
    ));
  }

  int currentIndex = 0;
  int currentTab = 0;

  // final screens = [
  //   TestHome(),
  //   MyRequest(),
  //   CreateRequest(),
  //   Notificationscreen(),
  //   Profile(),
  // ];

  // final List<Widget> screens2 = [
  //   TestHome(),
  //   MyRequest(),
  //   Notificationscreen(),
  //   Profile(),
  //   PleaseLogin(),
  // ];

  Widget home1() {
    return MaterialApp(
      // home: Register(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
                          currentScreen = AllRequest();
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
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          currentScreen = UserRequest();
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
                          currentScreen = UserRequestHistory();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            size: 28,
                            color: currentTab == 2
                                ? Color(0xFF005792)
                                : Colors.grey.shade600,
                          ),
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
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const TestHome(),
      // },
      // home: Register(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
              currentScreen = PleaseLogin(
                screenName: 'Create Request',
              );
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
                          currentScreen = AllRequest();
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
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          currentScreen = PleaseLogin(
                            screenName: 'Your Request',
                          );
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
                          currentScreen = PleaseLogin(
                            screenName: 'Notification',
                          );
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            size: 28,
                            color: currentTab == 2
                                ? Color(0xFF005792)
                                : Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          currentScreen = PleaseLogin(
                            screenName: 'Profile',
                          );
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
  Widget currentScreen = AllRequest();

  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    // return home1();
    if (loginKey == 0) {
      return home2(); // not logged in
    } else {
      return home1(); // logged in
    }
  }
}
