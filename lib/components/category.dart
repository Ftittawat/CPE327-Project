import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Map categorycolor = {
  'Mechanic': Colors.indigo.shade200,
  'Electric': Colors.orange.shade200,
  'Technology': Colors.teal.shade200,
  'Wooden': Colors.brown.shade200,
  'Plumbing': Colors.lightBlue.shade200,
  'Garden': Colors.green.shade200,
  'Other': Colors.blueGrey.shade200,
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
}
