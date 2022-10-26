import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/screens/setting.dart';

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
              /* ----------------- Your Skills Name ---------------- */
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
            ],
          ),
        ),
      ),
    );
  }
}
