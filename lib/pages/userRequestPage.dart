import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/components/category.dart';
import 'package:helpee/screens/showallrequest.dart';
import 'package:helpee/screens/showmyrequest.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class MyRequest extends StatefulWidget {
  const MyRequest({super.key});

  @override
  State<MyRequest> createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  /*---------------------- widgets ---------------------- */
  Widget searchBox() {
    return TextField(
      keyboardType: TextInputType.text,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
    );
  }

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

  Widget userRequest(String status) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Request")
            .where("Accepted By",
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
                                        : "Created Time : ${dateTime.day}/${dateTime.month}/${dateTime.year}, ${dateTime.hour}:${dateTime.minute}",
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
                          trailing: Icon(Icons.person),
                          isThreeLine: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowAllRequestScreen(
                                    data: data,
                                    docID: snapshot.data!.docs[index].id,
                                  ),
                                ));
                            print("docID : ${snapshot.data!.docs[index].id}");
                          }),
                    );
                  });
        },
      ),
    );
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
                    children: [userRequest("In Progress")],
                  ),
                  Column(
                    children: [userRequest("Completed")],
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
