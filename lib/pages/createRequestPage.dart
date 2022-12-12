import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:getwidget/getwidget.dart';

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

  File? file;
  String? picURL;

  Widget textLabel(String nametext) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Text(nametext,
          style: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
    );
  }

  Widget topicBox() {
    return TextFormField(
      controller: TopicController,
      // validator: ValidationBuilder().maxLength(20).minLength(1),
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          // hintText: 'Topic',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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

  Widget descriptionbox() {
    return TextFormField(
      controller: DescriptionController,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          // hintText: 'Description',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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

  String dropdownvalue = 'Other';
  var items = [
    'Mechanic',
    'Electronic',
    'Technology',
    'Food & Medicine',
    'Garden',
    'Other',
  ];

  Widget categoryBox() {
    return DropdownSearch<String>(
        popupProps: PopupProps.menu(
          showSearchBox: true,
          showSelectedItems: true,
          searchFieldProps: TextFieldProps(
            cursorColor: Color(0xFF005792),
            style: GoogleFonts.montserrat(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
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
                        BorderSide(width: 21.0, color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        dropdownButtonProps:
            DropdownButtonProps(splashRadius: 15, color: Colors.grey.shade400),
        items: items,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
              // hintText: 'Category',
              // hintStyle: GoogleFonts.montserrat(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //     color: Colors.grey.shade400),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.0, color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Color(0xFF005792)),
                  borderRadius: BorderRadius.circular(10))),
        ),
        onChanged: ((value) {
          dropdownvalue = value!;
        }));
  }

  Widget addressBox() {
    return TextFormField(
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          // hintText: 'Address',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
      minLines: 1,
      cursorColor: Color(0xFF005792),
      controller: AddressController,
    );
  }

  Widget zipcodeBox() {
    return TextFormField(
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          // hintText: 'Zip Code',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
      minLines: 1,
      cursorColor: Color(0xFF005792),
      controller: ZipCodeController,
    );
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker()
          .pickImage(source: imageSource, maxHeight: 800.0, maxWidth: 800.0);
      setState(() {
        file = File(object!.path);
      });
    } catch (e) {}
  }

  Widget imageBox() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFF005792) //elevated btton background color
                ),
            onPressed: () {
              chooseImage(ImageSource.camera);
            },
            icon: Icon(Icons.add_a_photo), //icon data for elevated button
            label: Text("Upload Image"), //label text
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFF005792) //elevated btton background color
                ),
            onPressed: () {
              chooseImage(ImageSource.gallery);
            },
            icon:
                Icon(Icons.add_photo_alternate), //icon data for elevated button
            label: Text("Choose Image"), //label text
          )
        ],
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
        border: Border.all(width: 1.0, color: Colors.grey.shade400),
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

  Future<void> uploadPicture() async {
    Random random = Random();
    int i = random.nextInt(10000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference =
        firebaseStorage.ref().child('RequestPic/Request$i.png');
    UploadTask uploadTask = reference.putFile(file!);

    picURL = await (await uploadTask).ref.getDownloadURL();
    print('URL = $picURL');
    //Uri pic = Uri.file(new File(file));
  }

  Widget createButton() {
    return ElevatedButton(
      onPressed: () async {
        if (file == null) {
          print('file = null');
        } else {
          await uploadPicture();
          setState(() {
            file = null;
          });
        }
        await requestCollection.add({
          "Topic": TopicController.text,
          "Description": DescriptionController.text,
          "Category": dropdownvalue,
          "Address": AddressController.text,
          "Zip Code": ZipCodeController.text,
          "Create Time": DateTime.now(),
          "Created By": FirebaseAuth.instance.currentUser?.uid,
          // "Accepted By": "",
          "Picture": picURL,
          "Status": "Available",
          "Lat": currentLocation.latitude,
          "Lng": currentLocation.longitude
        });
        TopicController.clear();
        DescriptionController.clear();
        AddressController.clear();
        ZipCodeController.clear();
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
          Text("Create Request",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ],
      ),
    );
  }

  Widget defaultPicture() {
    return SizedBox(
      width: 450.0,
      //height: 100.0,
      child: Card(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              Image.asset(
                "assets/images/upload.png",
                width: 250.0,
                height: 250.0,
              ),
              Text(
                'please upload image\n',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
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
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: textLabel('Topic')),
                            topicBox(),
                          ],
                        ),
                      ),
                      /* ----------------- Description ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: textLabel('Description')),
                            descriptionbox(),
                          ],
                        ),
                      ),
                      /* ----------------- Category ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: textLabel('Category')),
                            categoryBox(),
                          ],
                        ),
                      ),
                      /* ----------------- Address ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: textLabel('Address')),
                            addressBox(),
                          ],
                        ),
                      ),
                      /* ----------------- Zip Code ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: textLabel('Zip Code')),
                            zipcodeBox(),
                          ],
                        ),
                      ),
                      /* ----------------- Image ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: textLabel('Image')),
                            imageBox(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 25, 5),
                        child: SizedBox(
                          //width: 0.0,
                          child: file == null
                              ? defaultPicture()
                              //Image.asset("assets/images/upload.png")
                              : Image.file(file!),
                        ),
                      ),
                      const Divider(
                        height: 10,
                        thickness: 0,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.black,
                      ),
                      /* ----------------- Map ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                        child: GFButton(
                          onPressed: () {
                            _goToMe();
                          },
                          color: Color(0xFF005792),
                          text: "My location",
                          icon: Icon(
                            Icons.location_pin,
                            color: Colors.white,
                          ),
                          shape: GFButtonShape.standard,
                          fullWidthButton: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: mapBox(),
                      ),
                      const Divider(
                        height: 10,
                        thickness: 0,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.black,
                      ),
                      /* ----------------- Create Button ---------------- */
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
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
