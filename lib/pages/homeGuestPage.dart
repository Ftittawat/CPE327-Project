import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/components/filterChoice.dart';
import 'package:location/location.dart';
import 'package:helpee/screens/loginwithgoogle.dart';
import 'package:helpee/widgets/displayAllRequest.dart';
import 'package:helpee/widgets/displayAsGuest.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/authen_service.dart';
import '../widgets/userRequestWidget.dart';

class HomeGuest extends StatefulWidget {
  const HomeGuest({super.key});

  @override
  State<HomeGuest> createState() => _HomeGuestState();
}

class _HomeGuestState extends State<HomeGuest> {
  Widget seeRequest() {
    return Card(
      elevation: 3.0,
      color: Color(0xFF005792),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginWithGoogle()),
          ).then((value) {
            setState(() {
              print(" ## Set State Work");
            });
          });
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Get Started',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.arrow_forward_ios_outlined,
                        size: 20, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emergencycall(String name, String phonenumber, String imagepath) {
    return Card(
      elevation: 1.0,
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 2, color: Color(0xFF005792)),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                  child: Image(
                    image: AssetImage(imagepath),
                    width: 45,
                    height: 45,
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.call_outlined,
                              size: 20,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                phonenumber,
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ],
            ),
          ),
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
          'Hi, Guest',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF000000),
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(Icons.login_rounded),
                splashRadius: 20,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginWithGoogle()),
                  ).then((value) {
                    setState(() {
                      print(" ## Set State Work");
                    });
                  });
                },
              )),
        ],
      ),
      /* ----------------- Body ---------------- */
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 3),
                child: FutureBuilder(
                  future: checkVisible("In Progress"),
                  builder: (context, snapshot) {
                    return Visibility(
                      visible: false,
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
                padding: const EdgeInsets.only(bottom: 20),
                child: seeRequest(),
              ),
              emergencycall('Medical Emergency Call', '1669',
                  "assets/images/logo-1669.png"),
              emergencycall('Police', '191', "assets/images/logo-191.png"),
              emergencycall(
                  'Tourist Police', '1155', "assets/images/logo-1155.png"),
              emergencycall('Ambulance and Rescue', '1554',
                  "assets/images/logo-1554.png"),
              // emergencycall('Fire', '199', "assets/images/logo-191.png"),
              emergencycall('Crime', '1195', "assets/images/logo-1195.png"),
            ],
          ),
        ),
      ),
    );
  }
}
