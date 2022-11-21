import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/screens/setting.dart';
import 'package:helpee/screens/showallrequest.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../components/authen_service.dart';
import '../components/category.dart';
import '../models/ListRequest.dart';

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
                  content: Text("ยังลบไม่ได้นะจ้ะ",
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
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

  Widget userRequestHistory(String status) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Request")
            .where("Created By",
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("Status", isEqualTo: status)
            .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;

                    // Convert Timestamp to DateTime
                    DateTime? dateTime;
                    if (data['Create Time'] != null) {
                      Timestamp t = data['Create Time'] as Timestamp;
                      dateTime = t.toDate();
                    }
                    return Card(
                      child: ListTile(
                          /* ----------------- Title ---------------- */
                          title: Text(
                            "Topic: ${data["Topic"]}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF005792)),
                          ),
                          subtitle: Column(
                            children: [
                              /* ----------------- Category ---------------- */
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Category.tag("${data['category']}"),
                                ),
                              ),
                              /* ----------------- Subtitle ---------------- */
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Text(
                                  "Subtitle: ${data['Descrition']}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              /* ----------------- Distance ---------------- */
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      /* ----------------- Distance Icon ---------------- */
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 18,
                                        color: Colors.black,
                                      ),
                                      /* ----------------- Distance Text ---------------- */
                                      Text(
                                        "Distance ${data['distance']} kilometers.",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              /* ----------------- Date Time ---------------- */
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    dateTime == null
                                        ? "time is null"
                                        : "Created Time : ${dateTime!.day}/${dateTime!.month}/${dateTime!.year}, ${dateTime.hour}:${dateTime.minute}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // trailing: Icon(Icons.person),
                          // isThreeLine: true,
                          // onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => ShowAllRequestScreen(
                          //           data: data,
                          //           docID: snapshot.data!.docs[index].id,
                          //         ),
                          //       ));
                          // },
                          trailing: deleteButton(),
                          isThreeLine: true,
                          onTap: () {}),
                    );
                  });
        },
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
                      children: [userRequestHistory("Available")],
                    ),
                    Column(
                      children: [userRequestHistory("In Progress")],
                    ),
                    Column(
                      children: [userRequestHistory("Completed")],
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
              /* ----------------- Prifile Image ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  radius: 80,
                  backgroundImage: NetworkImage(
                      FirebaseAuth.instance.currentUser?.photoURL ??
                          "assets/images/Memoji.png"),
                  // backgroundImage: NetworkImage(
                  //     user?.photoURL! ?? "assets/images/Memoji.png"),
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
                  child: Text("History request",
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
                  child: historyAll(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
