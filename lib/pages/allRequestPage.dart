import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/components/filterChoice.dart';

import 'package:helpee/screens/loginwithgoogle.dart';
import 'package:helpee/pages/profilePage.dart';
import 'package:helpee/screens/showallrequest.dart';

import '../components/authen_service.dart';
import '../components/category.dart';
import '../models/user_models.dart';
import '../screens/login.dart';

class TestHome extends StatefulWidget {
  const TestHome({super.key});

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  final user = FirebaseAuth.instance.currentUser;

  final uid = FirebaseAuth.instance.currentUser?.uid;
  final String? displayName = FirebaseAuth.instance.currentUser?.displayName;
  String keywords = "";

  late String name, email;
  var loginKey;
  bool loginKey2 = true;
  var checkKey;
  @override
  void initState() {
    super.initState();

    print("--- ### AllRequest ### ---");

    print(uid);

    checkKey = check();
    print("Check = " + checkKey.toString());
  }

  /*---------------------- Search Box ---------------------- */
  Widget searchBox() {
    return TextField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.grey,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.search_outlined,
          color: Colors.grey.shade400,
        ),
        hintText: 'Search',
        hintStyle: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade400),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        filled: true,
        fillColor: Colors.grey.shade100,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Colors.grey.shade100),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Colors.grey.shade100),
            borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: (query) {
        setState(() {
          keywords = query;
        });
      },
    );
  }

  /*---------------------- Save Box ---------------------- */
  Widget saveButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF005792),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Save",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ],
      ),
    );
  }

  /*---------------------- Save Box ---------------------- */
  bool _selected = false;

  /*---------------------- Distance Slider ---------------------- */
  double _currentSliderValue = 10;

  Widget distanceSlider() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: StatefulBuilder(
          builder: ((context, setState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: CupertinoSlider(
                    min: 0.0,
                    max: 100.0,
                    activeColor: Color(0xFF005792),
                    value: _currentSliderValue,
                    onChanged: (value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                ),
                Text("${_currentSliderValue.round().toString()} Km.",
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ],
            );
          }),
        ));
  }

  /*---------------------- Filter Button ---------------------- */
  Widget filterButton() {
    return SizedBox(
      height: 30,
      width: 90,
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              builder: (BuildContext context) {
                return SizedBox(
                  height: 320,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Category",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                      child: FilterChoice.mechanic(
                                          (MediaQuery.of(context).size.width /
                                                  3) -
                                              50)),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                      child: FilterChoice.electric(
                                          (MediaQuery.of(context).size.width /
                                                  3) -
                                              50)),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                      child: FilterChoice.technology(
                                          (MediaQuery.of(context).size.width /
                                                  3) -
                                              50)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                      child: FilterChoice.garden(
                                          (MediaQuery.of(context).size.width /
                                                  3) -
                                              50)),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                      child: FilterChoice.wooden(
                                          (MediaQuery.of(context).size.width /
                                                  3) -
                                              50)),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                      child: FilterChoice.plumbing(
                                          (MediaQuery.of(context).size.width /
                                                  3) -
                                              50)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: FilterChoice.others(
                                          (MediaQuery.of(context).size.width /
                                                  3) -
                                              50)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Distance",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: distanceSlider()),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: SizedBox(
                            height: 45.0,
                            child: saveButton(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(width: 1.0, color: Colors.grey.shade400))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.tune_outlined,
              color: Colors.grey.shade400,
              size: 18,
            ),
            Text("Filter",
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade400)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /* ----------------- App Bar ---------------- */
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF005792),
        toolbarHeight: 60,
        title: Text(
          displayName == null ? 'Hi' : "Hi, $displayName",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF000000),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: IconButton(
              icon: const Icon(Icons.notifications),
              color: Colors.blueGrey.shade300,
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: checkKey == 0
                ? IconButton(
                    icon: const Icon(Icons.person),
                    splashRadius: 20,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginWithGoogle()),
                      ).then((value) {
                        setState(() {
                          print(" ## Set State Work");
                        });
                      });
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.logout),
                    splashRadius: 20,
                    onPressed: () {},
                  ),
          ),
        ],
      ),
      /* ----------------- Body ---------------- */
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10), child: searchBox()),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 3),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: const [
                    Icon(
                      Icons.warning,
                      size: 25,
                      color: Color.fromARGB(255, 255, 164, 19),
                    ),
                    Text(
                      " In Progresssss",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Request")
                    // .where("Status", isEqualTo: "Available")
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
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Category.tag(
                                                "${data['category']}"),
                                          ),
                                        ),
                                        /* ----------------- Subtitle ---------------- */
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 5),
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
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 5),
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
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              dateTime == null
                                                  ? "Created at : Unknown"
                                                  : "Created at : ${dateTime!.day}/${dateTime!.month}/${dateTime!.year}, ${dateTime.hour}:${dateTime.minute}",
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
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              data['Created By'] == null
                                                  ? "Created By : Anonymous"
                                                  : "Created By : ${data['Created By']}",
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
                                            builder: (context) =>
                                                ShowAllRequestScreen(
                                              data: data,
                                              docID:
                                                  snapshot.data!.docs[index].id,
                                            ),
                                          ));
                                      print(
                                          "docID : ${snapshot.data!.docs[index].id}");
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Category.tag(
                                              "${data['category']}"),
                                        ),
                                      ),
                                      /* ----------------- Subtitle ---------------- */
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
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
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 5),
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
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
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
                                        builder: (context) =>
                                            ShowAllRequestScreen(
                                          data: data,
                                          docID: snapshot.data!.docs[index].id,
                                        ),
                                      ),
                                    );
                                    print(snapshot.data!.docs[index].id);
                                  },
                                ),
                              );
                            }
                            return Container();
                          },
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
