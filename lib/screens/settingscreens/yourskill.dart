import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YourSkill extends StatefulWidget {
  const YourSkill({super.key});

  @override
  State<YourSkill> createState() => _YourSkillState();
}

class _YourSkillState extends State<YourSkill> {
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
          title: Text("Your Skill",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
        ),
      ),
    );
  }
}