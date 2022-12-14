import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/components/category.dart';
import 'package:helpee/screens/showCompleteRequest.dart';
import 'package:helpee/screens/showAcceptRequest.dart';
import 'package:helpee/screens/showRequestDetails.dart';
import 'package:location/location.dart';

@override
void initState() {
  findLatLng2();
}

late String name;
var lat2, lng2;

Future<Null> findLatLng2() async {
  var location2 = new Location();
  var currentLocation2 = await location2.getLocation();
  lat2 = currentLocation2.latitude;
  lng2 = currentLocation2.longitude;
  //print('lat2 = $lat2 lng2 = $lng2');
}

Widget userRequest(String query, String status) {
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
                          data['Lat'], data['Lng'], lat2!, lng2!) /
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
                          /* ----------------- Created By ---------------- */
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection("user")
                                    .doc(data["Created By"])
                                    .get()
                                    .then(
                                  (value) {
                                    name = value.data() == null
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Category.status("${data['Status']}")),
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
                          if (status == 'In progress') {
                            return [
                              PopupMenuItem(
                                value: 1,
                                child: Text(
                                  "Detail",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ];
                          } else {
                            return [
                              PopupMenuItem(
                                value: 3, // see details with completed request
                                child: Text(
                                  "Detail",
                                  style: TextStyle(fontSize: 14),
                                ),
                              )
                            ];
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
                                builder: (context) =>
                                    showAcceptRequestDetailsScreen(
                                  data: data,
                                  docID: snapshot.data!.docs[index].id,
                                ),
                              ));
                        } else if (status == 'Completed') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompleteRequestScreen(
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

/// function for check the visible tab for in progress task.
Future<bool> checkVisible(String status) async {
  QuerySnapshot doc = await FirebaseFirestore.instance
      .collection("Request")
      .where("Accepted By", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where("Status", isEqualTo: status)
      .get();
  List<DocumentSnapshot> data = doc.docs;
  print(data.length); // Count of Documents in Collection
  var result = data.isNotEmpty ? true : false;
  return result;
}
