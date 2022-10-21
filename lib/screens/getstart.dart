import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Getstart extends StatefulWidget {
  const Getstart({super.key});

  @override
  State<Getstart> createState() => _GetstartState();
}

class _GetstartState extends State<Getstart> {
  Widget getstartButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Get Start",
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF005792))),
          Icon(
            Icons.arrow_forward_rounded,
            size: 30,
            color: Color(0xFF005792),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF005792),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 140,
              child: Image.asset("assets/images/helpee1.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 40,
                child: Text("Welcome to helpee",
                    style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                height: 30,
                child: Text("Application for help in various fields",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
              ),
            ),
            SizedBox(
              height: 50,
              width: 320,
              child: getstartButton(),
            ),
          ],
        ),
      ),
    );
  }
}
