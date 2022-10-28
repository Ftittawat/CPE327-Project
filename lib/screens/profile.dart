import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/screens/setting.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget skillbox(String skillname, Color boxcolor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: boxcolor,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset.fromDirection(2.0),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(skillname,
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget requesthistory() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Container(
        color: Colors.white,
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width - 90,
                  height: 30,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("skillname",
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF005792))),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  color: Colors.white,
                  width: 40,
                  height: 30,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                    iconSize: 18,
                    splashRadius: 10,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 25,
                width: 100,
                child: skillbox('Mechanic', Colors.indigo.shade300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 2, 0, 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                  child: Text("finish: 15 Oct 2022, 10:35 ",
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade400)),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child:
                  Divider(height: 2, thickness: 2, color: Colors.grey.shade300),
            ),
          ],
        ),
      ),
    );
  }

  Widget historyall() {
    return Container(
      height: 220,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: SizedBox(
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 30,
                child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey.shade400,
                    indicatorColor: Colors.black,
                    indicator: MaterialIndicator(
                      height: 3,
                      bottomLeftRadius: 5,
                      bottomRightRadius: 5,
                      horizontalPadding: 50,
                      tabPosition: TabPosition.bottom,
                    ),
                    tabs: [
                      Tab(
                        child: Text("Your request",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      Tab(
                        child: Text("Provide assistance",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ]),
              ),
              SizedBox(
                height: 190,
                child: TabBarView(children: [
                  Center(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              children: [
                                requesthistory(),
                                requesthistory(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              children: [
                                requesthistory(),
                                requesthistory(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
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
          title: Text("Profile",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_vert_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Setting()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /* ----------------- Prifile Image ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  radius: 80,
                  backgroundImage: AssetImage("assets/images/Memoji.png"),
                ),
              ),
              /* ----------------- Username ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text("Tittawat",
                    style: GoogleFonts.montserrat(
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ),
              /* ----------------- Address ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Text("Thung khru, Bangkok.",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
              ),
              /* ----------------- Your Skills Name ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Your Skills",
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ),
              ),
              /* ----------------- Your Skills ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child:
                                skillbox('Mechanic', Colors.indigo.shade300)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child:
                                skillbox('Technology', Colors.green.shade300)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child:
                                skillbox('Electronic', Colors.pink.shade200)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: skillbox('Electronic', Colors.red.shade300)),
                      ],
                    ),
                  ),
                ),
              ),
              /* ----------------- History Name ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("History",
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ),
              ),
              /* ----------------- History TabBar ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Align(
                  alignment: Alignment.center,
                  child: historyall(),
                ),
              ),
              /* ----------------- History ----------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
