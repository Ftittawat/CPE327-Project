import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/components/category.dart';
import 'package:helpee/get_data/getMyRequest.dart';
import 'package:helpee/models/ListRequest.dart';
import 'package:helpee/screens/showallrequest.dart';
import 'package:helpee/screens/showmyrequest.dart';

class MyRequest extends StatefulWidget {
  const MyRequest({super.key});

  @override
  State<MyRequest> createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  // documents IDs
  List<String> docIDs = [];

  // get docIDs
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('Request').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              // print(document.reference);
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  void initState() {
    // getDocId();
    displayUserRequest();
    super.initState();
  }

  List userRequested = [];

  void displayUserRequest() async {
    final result = await FirebaseFirestore.instance
        .collection('Request')
        .where("Topic", isGreaterThanOrEqualTo: 'test pic')
        .get();

    setState(() {
      userRequested = result.docs.map((e) => e.data()).toList();
    });
  }

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
        title: Text("Your Request",
            style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
      ),

      /* ----------------- Body ---------------- */
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
            //   child: SizedBox(
            //     child: Align(
            //       alignment: Alignment.centerLeft,
            //       child: Text("Your Request",
            //           style: GoogleFonts.montserrat(
            //               fontSize: 16,
            //               fontWeight: FontWeight.w700,
            //               color: Colors.black)),
            //     ),
            //   ),
            // ),
            // This comment below is the widget that show all request by
            // Expanded(
            //   child: FutureBuilder(
            //     future: getDocId(),
            //     builder: (context, snapshot) {
            //       return ListView.builder(
            //         itemCount: docIDs.length,
            //         itemBuilder: ((context, index) {
            //           return GetMyRequests(documentID: docIDs[index]);
            //         }),
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: userRequested.length,
                itemBuilder: (BuildContext context, int index) {
                  DateTime? dateTime;
                  if (userRequested[index]["Create Time"] != null) {
                    Timestamp t =
                        userRequested[index]["Create Time"] as Timestamp;
                    dateTime = t.toDate();
                  }
                  return Card(
                    child: ListTile(
                        /* ----------------- Title ---------------- */
                        title: Text(
                          "Topic: ${userRequested[index]["Topic"]}",
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
                                child: Category.tag(
                                    "${userRequested[index]['category']}"),
                              ),
                            ),
                            /* ----------------- Subtitle ---------------- */
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Text(
                                userRequested[index]['Descrition'] == null
                                    ? "Subtitle: No details."
                                    : "Subtitle: ${userRequested[index]['Descrition']}",
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
                                      userRequested[index]['distance'] == null
                                          ? "Not specified distance."
                                          : "Distance ${userRequested[index]['distance']} kilometers.",
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
                        trailing: Icon(Icons.person),
                        isThreeLine: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowAllRequestScreen(
                                    data: userRequested[index]),
                              ));
                        }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
