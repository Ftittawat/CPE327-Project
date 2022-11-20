import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  Widget textLabel(String nametext) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Text(nametext,
          style: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
    );
  }

  Widget addressBox() {
    return TextField(
      obscureText: true,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          // hintText: 'Address',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
      minLines: 1,
      cursorColor: Color(0xFF005792),
    );
  }

  Widget provinceBox() {
    return TextField(
      obscureText: true,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          // hintText: 'Province',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
      minLines: 1,
      cursorColor: Color(0xFF005792),
    );
  }

  Widget cityBox() {
    return TextField(
      obscureText: true,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          // hintText: 'City',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
      minLines: 1,
      cursorColor: Color(0xFF005792),
    );
  }

  Widget zipcodeBox() {
    return TextField(
      obscureText: true,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          // hintText: 'Zip Code',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
      minLines: 1,
      cursorColor: Color(0xFF005792),
    );
  }

  Widget saveButton() {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Address is Change")));
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
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ],
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
          foregroundColor: Colors.black,
          title: Text("Address",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /* ----------------- Address ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: textLabel('Address')),
                    addressBox(),
                  ],
                ),
              ),
              /* ----------------- Province ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: textLabel('Province')),
                    provinceBox(),
                  ],
                ),
              ),
              /* ----------------- City ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: textLabel('City')),
                    cityBox(),
                  ],
                ),
              ),
              /* ----------------- Zip Code ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: textLabel('Zip Code')),
                    zipcodeBox(),
                  ],
                ),
              ),
              /* ----------------- Save Button ---------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: SizedBox(
                  height: 55.0,
                  child: saveButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
