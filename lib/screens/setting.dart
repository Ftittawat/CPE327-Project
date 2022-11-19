import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/screens/settingscreens/address.dart';
import 'package:helpee/screens/settingscreens/changepassword.dart';
import 'package:helpee/screens/settingscreens/editprofile.dart';
import 'package:helpee/screens/settingscreens/yourskill.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Widget editprofilebutton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditProfile()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Edit Profile",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          Icon(
            Icons.chevron_right,
            size: 25,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Widget changepasswordbutton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChangePassword()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Change Password",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          Icon(
            Icons.chevron_right,
            size: 25,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Widget yourskillbutton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => YourSkill()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Your Skill",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          Icon(
            Icons.chevron_right,
            size: 25,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Widget addressbutton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Address()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Address",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          Icon(
            Icons.chevron_right,
            size: 25,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Widget helpbutton() {
    return ElevatedButton(
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Login()),
        // );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Help",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          Icon(
            Icons.chevron_right,
            size: 25,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Widget logoutButton() {
    return ElevatedButton(

      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              title: Text("Log Out",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              content: Text("Are You Sure?",
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
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () async {
        await Firebase.initializeApp().then((value) async {
          await FirebaseAuth.instance.signOut().then((value) {
            Fluttertoast.showToast(
                msg: "Log-Out Success", gravity: ToastGravity.CENTER);
            Navigator.pop(context);
          });
        });
      },
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
              ],
            );
          },
        );
      ,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Log Out",
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
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text("Settings",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /* ----------------- Edit Prifile ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey))),
                  child: editprofilebutton(),
                ),
              ),
              /* ----------------- Chande Password ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey))),
                  child: changepasswordbutton(),
                ),
              ),
              /* ----------------- Your Skill ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey))),
                  child: yourskillbutton(),
                ),
              ),
              /* ----------------- Address ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey))),
                  child: addressbutton(),
                ),
              ),
              /* ----------------- Help ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey))),
                  child: helpbutton(),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Text("Version 0.0.1",
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: SizedBox(
                  height: 50.0,
                  child: logoutButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
