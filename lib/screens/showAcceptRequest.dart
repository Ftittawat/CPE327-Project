import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/category.dart';

class showAcceptRequestDetailsScreen extends StatelessWidget {
  final data;
  final String docID;
  const showAcceptRequestDetailsScreen(
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

  Set<Marker> mapMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId('myLocation'),
          position: LatLng(data['Lat'], data['Lng']),
          infoWindow: InfoWindow(
            title: "Request Location",
            snippet: "Lat = ${data['Lat']}, Lng =${data['Lng']} ",
          ))
    ].toSet();
  }

  Widget mapBox() {
    Completer<GoogleMapController> _controller = Completer();
    LatLng latLng = LatLng(data['Lat'], data['Lng']);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1.0, color: Colors.grey.shade400),
      ),
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: mapMarker(),
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
        title: Text("Request Details",
            style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              /* ----------------- Title ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("${data["Topic"]}",
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
                  child: Category.tag("${data["Category"]}"),
                ),
              ),

              /* ----------------- Sub Title ---------------- */
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("${data['Description']}",
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
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
              /* ----------------- Contact ---------------- */
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Contact Details",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ),
              ),
              /* ----------------- Show Helpee details ---------------- */
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('user')
                        .doc(data["Created By"])
                        .get()
                        .then((value) {
                      Map<String, dynamic>? userData = value.data();
                      // print(userData);
                      return userData;
                    }),
                    builder: (_, snapshot) {
                      return (snapshot.connectionState ==
                              ConnectionState.waiting)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                /* ----------------- Created By ---------------- */
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                        "Created By: ${snapshot.data!['name']}",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ),
                                ),
                                /* ----------------- Phone ---------------- */
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                        snapshot.data!['phone'] == null
                                            ? "Phone: NO PHONE."
                                            : "Phone: ${snapshot.data!['phone']}",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ),
                                ),
                                /* ----------------- Address ---------------- */
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                        data!['Address'] == null
                                            ? "Address: -"
                                            : "Address: ${data!['Address']}",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ),
                                ),
                                /* ----------------- Contact ---------------- */
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 20),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: mapBox(),
                                  ),
                                ),
                              ],
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
