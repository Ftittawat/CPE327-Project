import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/models/ListRequest.dart';
import 'package:helpee/screens/showallrequest.dart';

import '../components/category.dart';

class TestHome extends StatefulWidget {
  const TestHome({super.key});

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  /* group data */
  List<ListRequest> listrequest = [
    ListRequest(
        "Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me",
        "Mechanic",
        2.0),
    ListRequest("Repair sink",
        "My sink is leaking. Please fix the sink for me. :) ", "Technology", 3),
    ListRequest(
        "Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me sssssssssssssssssssssssssssssssssssssssssssssss",
        "Electronic",
        2.0),
    ListRequest(
        "Repair sink",
        "My sink is leaking. Please fix the sink for me. :(",
        "Food&Medicine",
        3),
    ListRequest(
        "Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me",
        "Health&Fitness",
        2.0),
    ListRequest("Repair sink",
        "My sink is leaking. Please fix the sink for me. :|", "Pet", 3),
    ListRequest(
        "Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me",
        "Garden",
        2.0),
    ListRequest("Repair sink",
        "My sink is leaking. Please fix the sink for me. :) ", "Other", 3),
    ListRequest(
        "Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me sssssssssssssssssssssssssssssssssssssssssssssss",
        "Mechanic",
        2.0),
    ListRequest("Repair sink",
        "My sink is leaking. Please fix the sink for me. :(", "Mechanic", 3),
    ListRequest(
        "Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me",
        "Mechanic",
        2.0),
    ListRequest("Repair sink",
        "My sink is leaking. Please fix the sink for me. :|", "Mechanic", 3),
  ];

  /*---------------------- widgets ---------------------- */
  Widget searchBox() {
    return TextField(
      keyboardType: TextInputType.text,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search_outlined,
            color: Colors.grey.shade400,
          ),
          hintText: 'Search',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        /* ----------------- App bar (Head) ---------------- */
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF005792),
          toolbarHeight: 80,
          title: Text("Hi Username",
              style: GoogleFonts.montserrat(
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF000000))),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is your icon')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: 'Go to the next page',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('You profile'),
                      ),
                      body: const Center(
                        child: Text(
                          'profile detail',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                ));
              },
            ),
          ],
        ),

        /* ----------------- Body ---------------- */
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  child: searchBox(),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Container(
                  height: MediaQuery.of(context).size.height - 260,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: ListView.builder(
                    itemCount: listrequest.length, //fix bound of request
                    itemBuilder: (BuildContext context, int index) {
                      ListRequest request = listrequest[index];
                      return Card(
                          child: ListTile(
                              /* ----------------- Title ---------------- */
                              title: Text(
                                request.title,
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
                                      child: Category.tag(request.category),
                                    ),
                                  ),
                                  /* ----------------- Subtitle ---------------- */
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Text(
                                      request.subtitle,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  /* ----------------- Distance ---------------- */
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 5),
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
                                            "Distance ${request.distance} kilometers.",
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
                                        "22 Oct 2022, 10:22",
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
                              // enabled: Text(true),
                              trailing: Icon(Icons.person),
                              isThreeLine: true,
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           ShowAllRequestScreen(
                                //               listRequest: request),
                                //     ));
                              }));
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
