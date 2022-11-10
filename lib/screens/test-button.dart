import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/screens/ListRequest.dart';
import 'package:helpee/screens/allRequest.dart';
import 'package:helpee/screens/profile.dart';
import 'package:helpee/screens/setting.dart';
import 'package:helpee/screens/myRequest.dart';
import 'package:helpee/screens/createrequest.dart';

class TestButton extends StatefulWidget {
  const TestButton({super.key});

  @override
  State<TestButton> createState() => _TestButtonState();
}

class _TestButtonState extends State<TestButton> {
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

  int currentTab = 0;
  final List<Widget> screens = [
    TestHome(),
    MyRequest(),
    Profile(),
    Setting(),
    CreateRequest()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = TestHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* ----------------- Body ---------------- */
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = TestHome();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = MyRequest();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'My Request',
                          style: TextStyle(
                              color:
                                  currentTab == 1 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // Right Tab Bar Icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Profile();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color:
                                  currentTab == 2 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Setting();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Setting',
                          style: TextStyle(
                              color:
                                  currentTab == 3 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
