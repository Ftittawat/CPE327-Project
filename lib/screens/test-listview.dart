import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/screens/ListRequest.dart';
import 'package:helpee/screens/test-listview.dart';

class TestHome extends StatefulWidget {
  const TestHome({super.key});

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  /* group data */
  List<ListRequest> list_request = [
    ListRequest("Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me", 2.0),
    ListRequest("Repair sink",
        "My sink is leaking. Please fix the sink for me. :) ", 3),
    ListRequest(
        "Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me sssssssssssssssssssssssssssssssssssssssssssssss",
        2.0),
    ListRequest(
        "Repair sink", "My sink is leaking. Please fix the sink for me. :(", 3),
    ListRequest("Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me", 2.0),
    ListRequest(
        "Repair sink", "My sink is leaking. Please fix the sink for me. :|", 3),
    ListRequest("Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me", 2.0),
    ListRequest("Repair sink",
        "My sink is leaking. Please fix the sink for me. :) ", 3),
    ListRequest(
        "Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me sssssssssssssssssssssssssssssssssssssssssssssss",
        2.0),
    ListRequest(
        "Repair sink", "My sink is leaking. Please fix the sink for me. :(", 3),
    ListRequest("Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me", 2.0),
    ListRequest(
        "Repair sink", "My sink is leaking. Please fix the sink for me. :|", 3),
  ];

  /*---------------------- widgets ---------------------- */
  Widget searchBox() {
    return TextField(
      keyboardType: TextInputType.text,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /* ----------------- App bar (Head) ---------------- */
        backgroundColor: Colors.white,
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  height: 500,
                  child: ListView.builder(
                    itemCount: list_request.length, //fix bound of request
                    itemBuilder: (BuildContext context, int index) {
                      ListRequest request = list_request[index];
                      return Card(
                          child: ListTile(
                              //leading: Text("test"),
                              title: Text(
                                request.title,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF005792)),
                              ),
                              subtitle: Text(
                                "${request.subtitle}\n\nDistance ${request.distance} kilometers.\n22 Oct 2022, 10:22",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                              // enabled: Text(true),
                              trailing: Icon(Icons.person),
                              isThreeLine: true,
                              onTap: () {
                                print("more detail ${request.title} ");
                              }));
                    },
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ));
  }
}
