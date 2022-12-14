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
  var phone;

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

  CollectionReference ref = FirebaseFirestore.instance.collection('user');
  var phoneController = new TextEditingController();
  var othersController = new TextEditingController();

  /* ----------------- Text Label ---------------- */
  Widget textLabel(String nametext) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Text(nametext,
          style: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
    );
  }

  /* ----------------- Username Field ---------------- */
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

  /* ----------------- Email Field ---------------- */
  Widget emailBox(String email) {
    return TextField(
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
        enabled: false,
        labelText: email,
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
    );
  }

  /* ----------------- Phone Field ---------------- */
  Widget phoneBox(String phoneNumber) {
    return TextField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
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

  /* ----------------- Other Contact Field ---------------- */
  Widget otherContactsBox(String? othersContact) {
    return TextField(
      controller: othersController,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
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

  /* ----------------- Save Button ---------------- */
  Widget saveButton() {
    return ElevatedButton(
      onPressed: () async {
        await ref.doc(uid).update({
          "phone": phoneController.text,
          "other": othersController.text,
        });

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        /* ----------------- AppBar ---------------- */
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
        /* ----------------- Body ---------------- */
        body: SingleChildScrollView(
          child: Center(
              child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('user')
                .doc(user!.uid)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic>? data = snapshot.data!.data();
                phoneController = TextEditingController(text: data!['phone']);
                othersController = TextEditingController(text: data['other']);
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
                    /* ----------------- Show Email ---------------- */
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: textLabel('Email')),
                          emailBox(data['email']),
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
                              child: textLabel('phone')),
                          phoneBox(data['phone'] == null
                              ? "Phone: NO PHONE."
                              : "Phone: ${data['phone']}"),
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
                          otherContactsBox(data['other']),
                        ],
                      ),
                    ),
                    /* ----------------- Save Button ---------------- */
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
                      child: SizedBox(
                        height: 55.0,
                        child: saveButton(),
                      ),
                    ),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          )),
        ),
      ),
    );
  }
}
