import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  Widget textLabel(String nametext) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Text(nametext,
          style: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
    );
  }

  Widget NameBox() {
    return TextField(
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          enabled: false,
          labelText: FirebaseAuth.instance.currentUser?.displayName ?? 'Neme',
          labelStyle: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
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

  Widget EmailBox() {
    return TextField(
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          enabled: false,
          labelText: FirebaseAuth.instance.currentUser?.email ?? 'Email',
          labelStyle: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
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

  Widget TopicBox() {
    return TextField(
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          // hintText: 'Enter Topic',
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
      minLines: 1,
      cursorColor: Color(0xFF005792),
    );
  }

  Widget MessageBox() {
    return TextField(
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

  Widget sendButton() {
    return ElevatedButton(
      onPressed: () {
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
          Text("Send",
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
          title: Text("Support",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
        ),
        body: Column(
          children: [
            /* ----------------- Add Name ---------------- */
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: textLabel('Name')),
                  NameBox(),
                ],
              ),
            ),
            /* ----------------- Add Email ---------------- */
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: textLabel('Email')),
                  EmailBox(),
                ],
              ),
            ),
            /* ----------------- Add Topic ---------------- */
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: textLabel('Topic')),
                  TopicBox(),
                ],
              ),
            ),
            /* ----------------- Add Message ---------------- */
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: textLabel('Message')),
                  MessageBox(),
                ],
              ),
            ),
            /* ----------------- Send Button ---------------- */
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 150),
              child: SizedBox(
                height: 55.0,
                child: sendButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
