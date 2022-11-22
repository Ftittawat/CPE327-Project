import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helpee/models/user_models.dart';
import 'package:helpee/screens/loginwithgoogle.dart';

class PleaseLogin extends StatefulWidget {
  final String screenName;

  const PleaseLogin({super.key, required this.screenName});

  @override
  State<PleaseLogin> createState() => _PleaseLoginState();
}

class _PleaseLoginState extends State<PleaseLogin> {
  Widget textLabel(String nametext) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Text(nametext,
          style: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
    );
  }

  Widget googleButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginWithGoogle()),
        ).then((value) {
          setState(() {
            print(" ## Set State Work");
          });
        });
      },
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Color(0xFF005792),
          // side: BorderSide(color: Colors.black54, width: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Log in",
              style: GoogleFonts.montserrat(
                  fontSize: 15,
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
          backgroundColor: Colors.white,
          /* ----------------- App Bar ---------------- */
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 60,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(widget.screenName,
                style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
          /* ----------------- Body ---------------- */
          body: SafeArea(
            child: Center(
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Please Login, First",
                              style: GoogleFonts.montserrat(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Log in to access the application.",
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text("Continue with Google",
                      //         style: GoogleFonts.montserrat(
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w500,
                      //             color: Colors.white)),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 50),
                        child: SizedBox(height: 44, child: googleButton()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
