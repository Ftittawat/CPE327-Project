import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CreateRequest extends StatefulWidget {
  const CreateRequest({super.key});

  @override
  State<CreateRequest> createState() => _CreateRequestState();
}

const darkblue = Color(0xFF005792);

class _CreateRequestState extends State<CreateRequest> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  CollectionReference requestCollection =
      FirebaseFirestore.instance.collection("Request");
  TextEditingController TopicController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  TextEditingController CategoryController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController ZipCodeController = TextEditingController();

  Widget topicBox() {
    return TextFormField(
      controller: TopicController,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          hintText: 'Topic',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
      minLines: 1,
      cursorColor: Color(0xFF005792),
    );
  }

  Widget descriptionbox() {
    return TextFormField(
      controller: DescriptionController,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          hintText: 'Description',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
      minLines: 2,
      maxLines: 3,
      cursorColor: Color(0xFF005792),
    );
  }

  String dropdownvalue = '';
  var items = [
    'Mechanic',
    'Electronic',
    'Technology',
    'Food & Medicine',
    'Garden',
    'Other',
  ];

  Widget selectCategory() {
    return DropdownButtonFormField(
      isExpanded: false,
      borderRadius: BorderRadius.circular(10),
      decoration: InputDecoration(
          hintText: 'Category',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(
            items,
            style: GoogleFonts.montserrat(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          dropdownvalue = value!;
        });
      },
    );
  }

  Widget categoryBox() {
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        showSearchBox: true,
        showSelectedItems: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade400),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              filled: true,
              fillColor: Colors.grey.shade100,
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.0, color: Colors.grey.shade100),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2.0, color: Colors.grey.shade100),
                  borderRadius: BorderRadius.circular(10))),
        ),
      ),
      items: items,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            hintText: 'Category',
            hintStyle: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade400),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
                borderRadius: BorderRadius.circular(10))),
      ),
      onChanged: print,

/*   Widget categoryBox() {
    return TextFormField(
      controller: CategoryController,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          hintText: 'Category',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
      minLines: 1,
      cursorColor: Color(0xFF005792),
    );
  } */

  Widget addressBox() {
    return TextFormField(
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          hintText: 'Address',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
      minLines: 1,
      cursorColor: Color(0xFF005792),
    );
  }

  Widget zipcodeBox() {
    return TextFormField(
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          hintText: 'Zip Code',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
      minLines: 1,
      cursorColor: Color(0xFF005792),
    );
  }

  Widget imageBox() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2.0, color: Colors.grey.shade400),
      ),
      child: Center(
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add_a_photo_outlined,
            color: Colors.grey.shade400,
            size: 40,
          ),
          padding: EdgeInsets.all(0.0),
          splashRadius: 30,
        ),
      ),
    );
  }

  //Map field
  Completer<GoogleMapController> _controller = Completer();
  late LocationData currentLocation;

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

  Future _goToMe() async {
    final GoogleMapController controller = await _controller.future;
    currentLocation = (await getCurrentLocation())!;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
      zoom: 16,
    )));
  }

  Widget mapBox() {
    LatLng latLng = LatLng(13.651158, 100.496454);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2.0, color: Colors.grey.shade400),
      ),
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Widget createButton() {
    return ElevatedButton(
      onPressed: () async {
        await requestCollection.add({
          "Topic": TopicController.text,
          "Descrition": DescriptionController.text,
          //"Category": CategoryController.text
        });
        TopicController.clear();
        DescriptionController.clear();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF005792),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Create Request",
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
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: Text("Error")),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
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
                    title: Text("Create request",
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                  ),
                  body: SingleChildScrollView(
                      child: Center(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /* ----------------- Topic ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: topicBox(),
                      ),
                      /* ----------------- Description ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: descriptionbox(),
                      ),
                      /* ----------------- Category ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: categoryBox(),
                      ),
                      /* ----------------- Address ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: addressBox(),
                      ),
                      /* ----------------- Zip Code ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: zipcodeBox(),
                      ),
                      /* ----------------- Image ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: imageBox(),
                      ),
                      /* ----------------- Map ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: mapBox(),
                      ),
                      /* ----------------- Create Button ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                        child: SizedBox(
                          height: 55.0,
                          child: createButton(),
                        ),
                      ),
                    ],
                  ))),
                ));
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
