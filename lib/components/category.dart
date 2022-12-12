import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Map categorycolor = {
  'mechanic': Colors.indigo.shade300,
  'electronic': Colors.orange.shade300,
  'technology': Colors.teal.shade300,
  'wooden': Colors.brown.shade300,
  'plumbing': Colors.lightBlue.shade300,
  'garden': Colors.green.shade300,
  'other': Colors.blueGrey.shade300,
};

Map statuscolor = {
  'In Progress': Colors.orange.shade400,
  'Available': Colors.green.shade400,
  'Completed': Colors.black,
};

class Category {
  static Widget tag(String name) {
    return Container(
      height: 25,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: categorycolor[name.toLowerCase()],
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset.fromDirection(2.0),
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(name,
              style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ),
      ),
    );
  }

  static Widget taginprofile(String name) {
    return Container(
      height: 30,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: categorycolor[name.toLowerCase()],
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset.fromDirection(2.0),
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(name,
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ),
      ),
    );
  }

  static Widget status(String name) {
    return Container(
      height: 25,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: statuscolor[name],
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black38,
        //     offset: Offset.fromDirection(2.0),
        //     blurRadius: 2.0,
        //   ),
        // ],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(name,
              style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ),
      ),
    );
  }
}
