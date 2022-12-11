import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/screens/profilescreen/setting.dart';
import 'package:helpee/widgets/userRequestWidget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../components/category.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser;
  late String name, displayName;
  var loginKey;
  var email;

  @override
  void initState() {
    super.initState();
    print("--- ### Proflie ### ---");
    loginCheck();
    // getData();
  }

  Future<Null> getData() async {
    // enter here the path , from where you want to fetch the doc
    print(user!.uid);
    DocumentSnapshot pathData = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();

    if (pathData.exists) {
      Map<String, dynamic>? fetchDoc = pathData.data() as Map<String, dynamic>?;
      var email = fetchDoc?['email'];
      print(email);
    }
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

  Widget skillBox(String skillname, Color boxcolor) {
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

  Widget historyAll() {
    return Container(
      height: 220,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: SizedBox(
        child: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(
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
                        child: Text("Available",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      Tab(
                        child: Text("In progress",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      Tab(
                        child: Text("Completed",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ]),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: [userRequest("Created By", "Available")],
                    ),
                    Column(
                      children: [userRequest("Created By", "In Progress")],
                    ),
                    Column(
                      children: [userRequest("Created By", "Completed")],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('user')
                    .doc(user!.uid)
                    .get(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic>? data = snapshot.data!.data();

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /* ----------------- Profile Image ---------------- */
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade400,
                            radius: 80,
                            backgroundImage: NetworkImage(
                                FirebaseAuth.instance.currentUser?.photoURL ??
                                    "assets/images/Memoji.png"),
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
                          child: Text(data!['email'],
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
                                      child:
                                          Category.taginprofile('Technology')),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: Category.taginprofile('Wooden')),
                                ],
                              ),
                            ),
                          ),
                        ),
                        /* ----------------- History TabBar ---------------- */
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("History Request",
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Align(
                            alignment: Alignment.center,
                            child: historyAll(),
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
