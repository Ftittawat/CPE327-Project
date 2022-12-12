import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/components/category.dart';
import 'package:helpee/screens/showAcceptHistory.dart';
import 'package:helpee/screens/showCompleteHistory.dart';
import 'package:helpee/screens/showCompleteRequest.dart';
import 'package:helpee/screens/showAcceptRequest.dart';
import 'package:helpee/screens/showRequestDetails.dart';
import 'package:location/location.dart';

late String name;
var lat3, lng3;

Future<Null> findLatLng3() async {
  var location3 = new Location();
  var currentLocation3 = await location3.getLocation();
  lat3 = currentLocation3.latitude;
  lng3 = currentLocation3.longitude;
  //print('lat2 = $lat2 lng2 = $lng2');
}

Widget userHistory(String query, String status, String cancel) {
  return Expanded(
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Request")
          .where(query, isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                  var data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  var dis = Geolocator.distanceBetween(
                          data['Lat'], data['Lng'], lat3!, lng3!) /
                      1000;
                  var disKm = dis.toStringAsFixed(2);

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
                        "${data["Topic"]}",
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
                              child: Category.tag("${data['Category']}"),
                            ),
                          ),
                          /* ----------------- Subtitle ---------------- */
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${data['Description']}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
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
                                    "Distance $disKm kilometers.",
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
                          /* ----------------- Accepted By ---------------- */
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection("user")
                                    .doc(data["Accepted By"])
                                    .get()
                                    .then(
                                  (value) {
                                    name = value.data() == null
                                        ? data["Accepted By"]
                                        : value.data()!["name"];
                                    return name;
                                  },
                                ),
                                builder: (context, snapshot) {
                                  return Text(
                                    data['Accepted By'] == null
                                        ? "Accepted By : Available"
                                        : "Accepted By : ${snapshot.data}",
                                    // : "Created By : ${snapshot.data}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade400,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton(
                        onSelected: (value) {
                          if (value == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ShowRequestDetailsScreen(
                                    data: data,
                                    docID: snapshot.data!.docs[index].id,
                                  ),
                                ));
                            print("docID : ${snapshot.data!.docs[index].id}");
                          }
                          if (value == 2) {
                            print("docID : ${snapshot.data!.docs[index].id}");
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  titlePadding:
                                      EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  title: Text("Confirm Cancel",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  content: Text(
                                      "Do you want to delete this request?",
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
                                      onPressed: () {
                                        Navigator.pop(context);
                                        FirebaseFirestore.instance
                                            .collection("Request")
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete()
                                            // .update({"Status": "Cancel"})
                                            .then((val) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(10)),
                                                  titlePadding:
                                                      EdgeInsets
                                                          .fromLTRB(20, 20, 20,
                                                              0),
                                                  title:
                                                      Text("Cancel Success!!",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black)),
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          20, 20, 20, 0),
                                                  content: Icon(
                                                    Icons.done_rounded,
                                                    color: Colors.blue,
                                                    size: 64.0,
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("OK"))
                                                  ]);
                                            },
                                          );
                                        });
                                      },
                                      child: Text(
                                        "Delete Request",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF005792)),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          if (value == 3) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CompleteRequestScreen(
                                    data: data,
                                    docID: snapshot.data!.docs[index].id,
                                  ),
                                ));
                          }
                        },
                        itemBuilder: (context) {
                          if (status == 'Available') {
                            return [
                              PopupMenuItem(
                                value: 1,
                                child: Text(
                                  "Detail",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ];
                          }
                          if (status == 'Completed') {
                            return [
                              PopupMenuItem(
                                value: 3, // see details with completed
                                child: Text(
                                  "Detail",
                                  style: TextStyle(fontSize: 14),
                                ),
                              )
                            ];
                          } else {
                            return [
                              PopupMenuItem(
                                value: 1,
                                child: Text(
                                  "Detail",
                                  style: TextStyle(fontSize: 14),
                                ),
                              )
                            ];
                            ;
                          }
                        },
                        offset: Offset(-10, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(6.0),
                            bottomRight: Radius.circular(6.0),
                            topLeft: Radius.circular(6.0),
                            topRight: Radius.circular(6.0),
                          ),
                        ),
                      ),
                      isThreeLine: true,
                      onTap: () {
                        if (status == 'In Progress') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowAcceptHistoryScreen(
                                  data: data,
                                  docID: snapshot.data!.docs[index].id,
                                ),
                              ));
                        } else if (status == 'Completed') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompleteHistoryScreen(
                                  data: data,
                                  docID: snapshot.data!.docs[index].id,
                                ),
                              ));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowRequestDetailsScreen(
                                  data: data,
                                  docID: snapshot.data!.docs[index].id,
                                ),
                              ));
                        }
                        print("status : $status");
                        print("docID : ${snapshot.data!.docs[index].id}");
                      },
                    ),
                  );
                },
              );
      },
    ),
  );
}
