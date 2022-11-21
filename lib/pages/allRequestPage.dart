import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/components/filterChoice.dart';

import 'package:helpee/screens/loginwithgoogle.dart';
import 'package:helpee/widgets/displayAllRequest.dart';

import '../components/authen_service.dart';
import '../widgets/userRequestWidget.dart';

class AllRequest extends StatefulWidget {
  const AllRequest({super.key});

  @override
  State<AllRequest> createState() => _AllRequestState();
}

class _AllRequestState extends State<AllRequest> {
  final user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final String? displayName = FirebaseAuth.instance.currentUser?.displayName;

  String keywords = "";

  late String name;
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

  var isVisible = checkVisible("In Progress");
  // var getBool = await checkVisible("In Progress");

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
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Align(
                    alignment: Alignment.centerLeft, child: filterButton())),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 3),
              child: FutureBuilder(
                future: checkVisible("In Progress"),
                builder: (context, snapshot) {
                  return Visibility(
                    visible: false,
                    // visible: checkVisible("In Progress"),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.warning_rounded,
                              size: 25,
                              color: Color.fromARGB(255, 255, 164, 19),
                            ),
                            Text(
                              " In Progress",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 3),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: const [
                    Icon(
                      Icons.warning_rounded,
                      size: 25,
                      color: Color.fromARGB(255, 4, 163, 17),
                    ),
                    Text(
                      " Available Request",
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
            displayAllRequest(),
          ],
        ),
      ),
    );
  }
}
