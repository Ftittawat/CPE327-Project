import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/components/category.dart';
import 'package:helpee/screens/acceptRequest.dart';
import 'package:helpee/screens/showRequestDetails.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../widgets/userRequestWidget.dart';

class MyRequest extends StatefulWidget {
  const MyRequest({super.key});

  @override
  State<MyRequest> createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  Widget cancelButton() {
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
                  title: Text("Cancel Request",
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
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF005792)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Confirm",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* ----------------- App bar (Head) ---------------- */
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Accepted Request",
            style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
      ),

      /* ----------------- Body ---------------- */
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: DefaultTabController(
          length: 2,
          child: Column(children: [
            TabBar(
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
                tabs: const [
                  Tab(text: "In Progress"),
                  Tab(text: "Completed"),
                ]),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [userRequest("Accepted By", "In Progress")],
                  ),
                  Column(
                    children: [userRequest("Accepted By", "Completed")],
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
