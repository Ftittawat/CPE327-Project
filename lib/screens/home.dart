import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String name, email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findNameAndEmail();
  }

  Future<Null> findNameAndEmail() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = FirebaseAuth.instance.currentUser!.displayName!;
          email = FirebaseAuth.instance.currentUser!.email!;
        });
      });
    });
  }

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
        toolbarHeight: 100,
        title: Text(" Hi Username             icon",
            style: GoogleFonts.montserrat(
                fontSize: 27,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000000))),
      ),

      /* ----------------- Body ---------------- */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: searchBox(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                "filterssdd",
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
