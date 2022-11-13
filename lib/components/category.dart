import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Map categorycolor = {
  'Mechanic': Colors.indigo.shade300,
  'Electric': Colors.orange.shade300,
  'Technology': Colors.teal.shade300,
  'Wooden': Colors.brown.shade300,
  'Plumbing': Colors.lightBlue.shade300,
  'Garden': Colors.green.shade300,
  'Other': Colors.blueGrey.shade300,
};

class Category {
  static Widget tag(String name) {
    return Container(
      height: 25,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: categorycolor[name],
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
        color: categorycolor[name],
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
}
