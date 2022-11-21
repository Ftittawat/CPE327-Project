import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/category.dart';

class ShowAllRequestScreen extends StatelessWidget {
  final data;
  final String docID;
  const ShowAllRequestScreen(
      {super.key, required this.data, required this.docID});

  Widget imageBox() {
    String imageURL = data["Picture"] ?? " ";

    return Container(
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2.0, color: Colors.grey.shade400),
      ),
      child: Center(
        child: imageURL == " "
            ? Icon(
                Icons.photo,
                color: Colors.grey.shade400,
                size: 40,
              )
            : Image.network(imageURL),
      ),
    );
  }

  Widget acceptRequest(BuildContext context) {
    DocumentReference<Map<String, dynamic>> requestCollection =
        FirebaseFirestore.instance.collection("Request").doc(docID);

    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              title: Text("Confirm",
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
                        fontWeight: FontWeight.w600, color: Color(0xFF005792)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    requestCollection.update({
                      "Accepted By": FirebaseAuth.instance.currentUser?.uid,
                      "Status": "In Progress",
                    });
                    print("Accept Success!!");
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              title: Text("Confirmation",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 20, 20, 0),
                              content: Icon(
                                Icons.done_rounded,
                                color: Colors.blue,
                                size: 64.0,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"))
                              ]);
                        });
                  },
                  child: Text(
                    "Accept Request",
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
          Text("Accept Request",
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
    DateTime? dateTime;
    if (data["Create Time"] != null) {
      Timestamp t = data["Create Time"] as Timestamp;
      dateTime = t.toDate();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text("Request",
            style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            /* ----------------- Title ---------------- */
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Topic: ${data["Topic"]}",
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF005792))),
              ),
            ),
            /* ----------------- Category ---------------- */
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Category.tag("${data["category"]}"),
              ),
            ),
            /* ----------------- Created By ---------------- */
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("user")
                      .doc(data["Created By"])
                      .get()
                      .then(
                    (value) {
                      String name = value.data() == null
                          ? data["Created By"]
                          : value.data()!["name"];
                      return name;
                    },
                  ),
                  builder: (context, snapshot) {
                    return Text(
                      data['Created By'] == null
                          ? "Created By : Anonymous"
                          : "Created By : ${snapshot.data}",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    );
                  },
                ),
              ),
            ),
            /* ----------------- Sub Title ---------------- */
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Subtitle: ${data['Descrition']}",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black)),
              ),
            ),
            /* ----------------- Image ---------------- */
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: imageBox(),
            ),
            /* ----------------- Date Time ---------------- */
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                    dateTime == null
                        ? "time is null"
                        : "Created Time : ${dateTime.day}/${dateTime.month}/${dateTime.year}, ${dateTime.hour}:${dateTime.minute}",
                    style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade400)),
              ),
            ),
            /* ----------------- Accept Request ---------------- */
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: SizedBox(
                height: 55.0,
                child: acceptRequest(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
