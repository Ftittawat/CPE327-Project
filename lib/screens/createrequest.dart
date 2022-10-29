import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  Widget categoryBox() {
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
  }

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
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2.0, color: Colors.grey.shade400),
      ),
    );
  }

  Widget createButton() {
    return ElevatedButton(
      onPressed: () {
        requestCollection.add({
          "Topic": TopicController.text,
          "Descrition": DescriptionController.text,
          "Category": CategoryController.text
        });
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: topicBox(),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: descriptionbox(),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: categoryBox(),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: addressBox(),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: zipcodeBox(),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: imageBox(),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: SizedBox(
                      height: 55.0,
                      child: createButton(),
                    ),
                  ),
                ],
              ),
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
                  body: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: topicBox(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: descriptionbox(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: categoryBox(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: addressBox(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: zipcodeBox(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: imageBox(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                        child: SizedBox(
                          height: 55.0,
                          child: createButton(),
                        ),
                      ),
                    ],
                  ))),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
