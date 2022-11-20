import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/screens/setting.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../components/authen_service.dart';
import '../components/category.dart';
import 'ListRequest.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser;
  late String name, email, displayName;
  var loginKey;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("--- ### Proflie ### ---");
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

  /* group data */
  List<ListRequest> list_request = [
    ListRequest(
        "Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me.",
        "Mechanic",
        2.0),
    ListRequest(
        "My computer won't turn on",
        "My computer was working fine before, But today my computer won't turn on. ",
        "Technology",
        3),
    ListRequest(
        "Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me.",
        "Electric",
        2.0),
    ListRequest(
        "Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me.",
        "Electric",
        2.0),
  ];

  Widget skillbox(String skillname, Color boxcolor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: boxcolor,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset.fromDirection(2.0),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(skillname,
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget deleteButton() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  title: Text("Delete",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  // content: Text("Are You Sure?",
                  //     style: GoogleFonts.montserrat(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w500,
                  //         color: Colors.black)),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF005792)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF005792)),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(Icons.delete_outlined),
          iconSize: 20,
          splashRadius: 15,
          color: Colors.grey.shade400,
        ));
  }

  Widget requesthistory() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: SizedBox(
        height: 295,
        child: ListView.builder(
          itemCount: list_request.length, //fix bound of request
          itemBuilder: (BuildContext context, int index) {
            ListRequest request = list_request[index];
            return Card(
                child: ListTile(
                    title: Text(
                      request.title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF005792)),
                    ),
                    subtitle: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Category.tag(request.category),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "22 Oct 2022, 10:22",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: deleteButton(),
                    isThreeLine: true,
                    onTap: () {}));
          },
        ),
      ),
    );
  }

  Widget historyall() {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 30,
            child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.shade400,
                indicatorColor: Colors.black,
                indicator: MaterialIndicator(
                  height: 3,
                  bottomLeftRadius: 5,
                  bottomRightRadius: 5,
                  horizontalPadding: 50,
                  tabPosition: TabPosition.bottom,
                ),
                tabs: [
                  Tab(
                    child: Text("Your request",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  Tab(
                    child: Text("Provide assistance",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ]),
          ),
          SizedBox(
            height: 300,
            child: TabBarView(children: [
              Center(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: requesthistory(),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: requesthistory(),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

//   getProfileImage() {
//     if (FirebaseAuth.instance.currentUser?.photoURL != null) {
//       return Image.network(
// ;
//     } else {}
//   }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Profile",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_vert_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Setting()),
                ).then((value) {
                  setState(() {
                    print("Set State");
                  });
                });
              },
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /* ----------------- Prifile Image ---------------- */
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade400,
                    radius: 80,
                    backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser!.photoURL.toString()),
                  ),
                ),
                /* ----------------- Username ---------------- */
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                      FirebaseAuth.instance.currentUser?.displayName ??
                          'DisplayName',
                      style: GoogleFonts.montserrat(
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ),
                /* ----------------- Address ---------------- */
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Text("Thung khru, Bangkok.",
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ),
                /* ----------------- Your Skills Name ---------------- */
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Your Skills",
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                  ),
                ),
                /* ----------------- Your Skills ---------------- */
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Category.taginprofile('Mechanic')),
                          Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Category.taginprofile('Electric')),
                          Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Category.taginprofile('Technology')),
                          Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Category.taginprofile('Wooden')),
                        ],
                      ),
                    ),
                  ),
                ),
                /* ----------------- History Name ---------------- */
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("History",
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                  ),
                ),
                /* ----------------- History TabBar ---------------- */
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: historyall(),
                  ),
                ),
                /* ----------------- History ----------------- */
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
