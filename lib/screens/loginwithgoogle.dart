import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({super.key});

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  Widget textLabel(String nametext) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Text(nametext,
          style: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
    );
  }

  Widget googleButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          // side: BorderSide(color: Colors.black54, width: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image(
              image: AssetImage("assets/images/google.png"),
              width: 22,
              height: 22,
            ),
          ),
          Text("Log in with Google",
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Scaffold(
          backgroundColor: Color(0xFF005792),
          /* ----------------- App Bar ---------------- */
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFF005792),
            foregroundColor: Colors.white,
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: const Icon(
                    Icons.close_outlined,
                    size: 35,
                  ),
                  splashRadius: 20,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          /* ----------------- Body ---------------- */
          body: SafeArea(
            child: Center(
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Image.asset("assets/images/helpee1.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Welcome to Helpee",
                              style: GoogleFonts.montserrat(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Application for help in various fields",
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text("Continue with Google",
                      //         style: GoogleFonts.montserrat(
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w500,
                      //             color: Colors.white)),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 50),
                        child: SizedBox(height: 44, child: googleButton()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
