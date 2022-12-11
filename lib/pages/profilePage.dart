import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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

  final uid = FirebaseAuth.instance.currentUser?.uid;

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

  CollectionReference ref = FirebaseFirestore.instance.collection('user');
  TextEditingController phoneController = TextEditingController();
  TextEditingController othersController = TextEditingController();


  Widget textLabel(String nametext) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Text(nametext,
          style: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
    );
  }

  Widget usernameBox() {
    return TextField(
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
        enabled: false,
        labelText:
            FirebaseAuth.instance.currentUser?.displayName ?? 'DisplayName',
        labelStyle: GoogleFonts.montserrat(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
    );
  }

  Widget emailBox() {
    return TextField(
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
        enabled: false,
        labelText: FirebaseAuth.instance.currentUser?.email ?? 'Email',
        labelStyle: GoogleFonts.montserrat(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
    );
  }

  Widget phoneBox() {
    return TextField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          // hintText: 'Phone',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          //labelText: ,

          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
      minLines: 1,
      cursorColor: Color(0xFF005792),
    );
  }

  Widget otherContactsBox() {
    return TextField(
      controller: othersController,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          // hintText: 'Phone',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),

          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
      minLines: 2,
      maxLines: 3,
      cursorColor: Color(0xFF005792),
    );
  }

  Widget saveButton() {
    return ElevatedButton(
      onPressed: () async {
        await ref.doc(uid).update({
          "Phone": phoneController.text,
          "Others Contact": othersController.text,
        });
        phoneController.clear();
        othersController.clear();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              title: Text("Success",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Color(0xFF005792)),
                  ),
                ),
              ],
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF005792),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Save Changes",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ],
      ),
    );
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
        body: SingleChildScrollView(
          child: Center(
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
                /* ----------------- Show Email ---------------- */
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: textLabel('Email')),
                      emailBox(),
                    ],
                  ),
                ),
                /* ----------------- Edit Phone ---------------- */
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: textLabel('Phone')),
                      phoneBox(),
                    ],
                  ),
                ),
                /* ----------------- Edit Other Contact ---------------- */
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: textLabel('Other Contact (Optional)')),
                      otherContactsBox(),
                    ],
                  ),
                ),
                /* ----------------- Save Button ---------------- */
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 150),
                  child: SizedBox(
                    height: 55.0,
                    child: saveButton(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}
