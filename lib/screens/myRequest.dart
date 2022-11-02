import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/screens/ListRequest.dart';
import 'package:helpee/screens/allRequest.dart';

class MyRequest extends StatefulWidget {
  const MyRequest({super.key});

  @override
  State<MyRequest> createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  /* group data */
  List<ListRequest> list_request = [
    ListRequest(
        "Repair pipe",
        "The water pipe has a crack, Please fix the water pipes for me.",
        "Mechanic",
        2.0),
    ListRequest(
        "My computer won't turn on",
        "My computer was working fine before, But today my computer won't turn on. ",
        "Technology",
        3)
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

  Widget cancelButton() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.delete_outlined),
          iconSize: 20,
          splashRadius: 10,
          color: Colors.grey.shade400,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* ----------------- App bar (Head) ---------------- */
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Ask for help",
            style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
      ),

      /* ----------------- Body ---------------- */
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: SizedBox(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Your Request",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 210,
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
                              "${request.subtitle}\n22 Oct 2022, 10:22",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                            // enabled: Text(true),
                            trailing: cancelButton(),
                            isThreeLine: true,
                            onTap: () {
                              print("more detail ${request.title} ");
                            }));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
