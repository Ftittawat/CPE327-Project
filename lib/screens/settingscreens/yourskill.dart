import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YourSkill extends StatefulWidget {
  const YourSkill({super.key});

  @override
  State<YourSkill> createState() => _YourSkillState();
}

List<String> listcategory = [
  'Mechanic',
  'Electric',
  'Technology',
  'Garden',
  'Wooden',
  'Plumbing',
  'Others'
];

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
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              DropdownSearch<String>.multiSelection(
                items: listcategory,
                popupProps: PopupPropsMultiSelection.menu(
                  showSelectedItems: true,
                  showSearchBox: true,
                  menuProps: MenuProps(borderRadius: BorderRadius.circular(10)),
                  searchFieldProps: TextFieldProps(
                    cursorColor: Color(0xFF005792),
                    decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade400),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.0, color: Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0, color: Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      hintText: 'Select Skill',
                      hintStyle: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade400),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2.0, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2.0, color: Color(0xFF005792)),
                          borderRadius: BorderRadius.circular(10))),
                ),
                onChanged: print,
              )
            ],
          ),
        ),
      ),
    );
  }
}
