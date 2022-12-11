import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:helpee/components/category.dart';
import 'package:helpee/screens/acceptRequest.dart';
import 'package:location/location.dart';

String keywords = "";
var lat, lng;

late String name;

Future<Null> findLatLng() async {
  LocationData? locationData = await getCurrentLocation();
  lat = locationData?.latitude;
  lng = locationData?.longitude;
  print('lat = $lat lng = $lng');
}

LocationData? currentLocation;
Future<LocationData?> getCurrentLocation() async {
  Location location = Location();
  try {
    return await location.getLocation();
  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION_DENIED') {
      // Permission denied
    }
    return null;
  }
}

// late String uid;
var query;


Widget displayAllRequest() {
  var uid2 = FirebaseAuth.instance.currentUser!.uid;
  var collection = FirebaseFirestore.instance.collection("Request");
  print("uid from displayAll: " + uid2.toString());

  query = collection
      // .where("Created By", isNotEqualTo: uid2)
      .where("Status", isEqualTo: "Available")
      .snapshots();

  return Expanded(
    child: StreamBuilder<QuerySnapshot>(
      stream: query,
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
                          data['Lat'], data['Lng'], lat!, lng!)
                      .toStringAsFixed(0);
                  print('dis = $dis');

                  // Convert Timestamp to DateTime
                  DateTime? dateTime;
                  if (data['Create Time'] != null) {
                    Timestamp t = data['Create Time'] as Timestamp;
                    dateTime = t.toDate();
                  }

                  // empty keywords
                  if (keywords.isEmpty) {
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
                                  child: Category.tag("${data['Category']}"),
                                ),
                              ),
                              /* ----------------- Subtitle ---------------- */
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Description: ${data['Description']}",
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
                                        "Distance $dis kilometers.",
                                        /* ***** */
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
                                        ? "Created at : Unknown"
                                        : "Created at : ${dateTime.day}/${dateTime.month}/${dateTime.year}, ${dateTime.hour}:${dateTime.minute}",
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
                  }
                  // entered keywords
                  if (data["Topic"]
                      .toString()
                      .toLowerCase()
                      .contains(keywords.toLowerCase())) {
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
                                child: Category.tag("${data['Category']}"),
                              ),
                            ),
                            /* ----------------- Subtitle ---------------- */
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Text(
                                "Description: ${data['Description']}",
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
                                      "Distance $dis kilometers.",
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
                            ),
                          );
                          print("docID : ${snapshot.data!.docs[index].id}");
                        },
                      ),
                    );
                  }
                  return Container();
                },
              );
      },
    ),
  );
}
