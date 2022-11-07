import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/screens/ListRequest.dart';
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

  /*---------------------- Search Box ---------------------- */
  Widget searchBox() {
    return TextField(
      keyboardType: TextInputType.text,
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
          fillColor: Colors.grey.shade400,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
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

  Widget categorgButton() {
    return StatefulBuilder(builder: ((context, setState) {
      return ChoiceChip(
          selected: _selected,
          label: Text("Settings",
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              )),
          labelStyle: TextStyle(
            color: _selected ? Colors.white : Colors.grey.shade400,
          ),
          disabledColor: Colors.white,
          selectedColor: Color(0xFF005792),
          backgroundColor: Colors.white,
          side: BorderSide(
              color: _selected ? Color(0xFF005792) : Colors.grey.shade400,
              width: _selected ? 0 : 1.5),
          onSelected: (bool selected) {
            setState(() {
              _selected = !_selected;
            });
          });
    }));
  }

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
                  height: 300,
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
                            padding: EdgeInsets.only(top: 20),
                            child: SizedBox(
                              height: 50,
                              child: categorgButton(),
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
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
        title: Text("Hi Username",
            style: GoogleFonts.montserrat(
                fontSize: 27,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000000))),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(Icons.person),
              splashRadius: 20,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is your icon')));
              },
            ),
          ),
        ],
      ),
      /* ----------------- Body ---------------- */
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text("Hi Username",
            //         style: GoogleFonts.montserrat(
            //             fontSize: 27,
            //             fontWeight: FontWeight.w700,
            //             color: Color(0xFF000000))),
            //   ),
            // ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: searchBox()),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Align(
                    alignment: Alignment.centerLeft, child: filterButton())),
            Expanded(
              child: ListView.builder(
                itemCount: listrequest.length,
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
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowAllRequestScreen(
                                      listRequest: request),
                                ));
                          }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
