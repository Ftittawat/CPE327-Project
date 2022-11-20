import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

bool _selectedMachanic = false;
bool _selectedElectric = false;
bool _selectedTechnology = false;
bool _selectedGarden = false;
bool _selectedWooden = false;
bool _selectedPlumbing = false;
bool _selectedOthers = false;

class FilterChoice {
  static Widget mechanic(double choicesize) {
    return StatefulBuilder(builder: ((context, setState) {
      return ChoiceChip(
          selected: _selectedMachanic,
          label: SizedBox(
            width: choicesize,
            child: Text(
              'Machanic',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          labelStyle: TextStyle(
            color: _selectedMachanic ? Colors.white : Colors.grey.shade400,
          ),
          disabledColor: Colors.white,
          selectedColor: Color(0xFF005792),
          backgroundColor: Colors.white,
          side: BorderSide(
              color:
                  _selectedMachanic ? Color(0xFF005792) : Colors.grey.shade400,
              width: _selectedMachanic ? 1.5 : 1.5),
          onSelected: (bool selected) {
            setState(() {
              _selectedMachanic = !_selectedMachanic;
            });
          });
    }));
  }

  static Widget electric(double choicesize) {
    return StatefulBuilder(builder: ((context, setState) {
      return ChoiceChip(
          selected: _selectedElectric,
          label: SizedBox(
            width: choicesize,
            child: Text(
              'Electric',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          labelStyle: TextStyle(
            color: _selectedElectric ? Colors.white : Colors.grey.shade400,
          ),
          disabledColor: Colors.white,
          selectedColor: Color(0xFF005792),
          backgroundColor: Colors.white,
          side: BorderSide(
              color:
                  _selectedElectric ? Color(0xFF005792) : Colors.grey.shade400,
              width: _selectedElectric ? 1.5 : 1.5),
          onSelected: (bool selected) {
            setState(() {
              _selectedElectric = !_selectedElectric;
            });
          });
    }));
  }

  static Widget technology(double choicesize) {
    return StatefulBuilder(builder: ((context, setState) {
      return ChoiceChip(
          selected: _selectedTechnology,
          label: SizedBox(
            width: choicesize,
            child: Text(
              'Technology',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          labelStyle: TextStyle(
            color: _selectedTechnology ? Colors.white : Colors.grey.shade400,
          ),
          disabledColor: Colors.white,
          selectedColor: Color(0xFF005792),
          backgroundColor: Colors.white,
          side: BorderSide(
              color: _selectedTechnology
                  ? Color(0xFF005792)
                  : Colors.grey.shade400,
              width: _selectedTechnology ? 1.5 : 1.5),
          onSelected: (bool selected) {
            setState(() {
              _selectedTechnology = !_selectedTechnology;
            });
          });
    }));
  }

  static Widget garden(double choicesize) {
    return StatefulBuilder(builder: ((context, setState) {
      return ChoiceChip(
          selected: _selectedGarden,
          label: SizedBox(
            width: choicesize,
            child: Text(
              'Garden',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          labelStyle: TextStyle(
            color: _selectedGarden ? Colors.white : Colors.grey.shade400,
          ),
          disabledColor: Colors.white,
          selectedColor: Color(0xFF005792),
          backgroundColor: Colors.white,
          side: BorderSide(
              color: _selectedGarden ? Color(0xFF005792) : Colors.grey.shade400,
              width: _selectedGarden ? 1.5 : 1.5),
          onSelected: (bool selected) {
            setState(() {
              _selectedGarden = !_selectedGarden;
            });
          });
    }));
  }

  static Widget wooden(double choicesize) {
    return StatefulBuilder(builder: ((context, setState) {
      return ChoiceChip(
          selected: _selectedWooden,
          label: SizedBox(
            width: choicesize,
            child: Text(
              'Wooden',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          labelStyle: TextStyle(
            color: _selectedWooden ? Colors.white : Colors.grey.shade400,
          ),
          disabledColor: Colors.white,
          selectedColor: Color(0xFF005792),
          backgroundColor: Colors.white,
          side: BorderSide(
              color: _selectedWooden ? Color(0xFF005792) : Colors.grey.shade400,
              width: _selectedWooden ? 1.5 : 1.5),
          onSelected: (bool selected) {
            setState(() {
              _selectedWooden = !_selectedWooden;
            });
          });
    }));
  }

  static Widget plumbing(double choicesize) {
    return StatefulBuilder(builder: ((context, setState) {
      return ChoiceChip(
          selected: _selectedPlumbing,
          label: SizedBox(
            width: choicesize,
            child: Text(
              'Plumbing',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          labelStyle: TextStyle(
            color: _selectedPlumbing ? Colors.white : Colors.grey.shade400,
          ),
          disabledColor: Colors.white,
          selectedColor: Color(0xFF005792),
          backgroundColor: Colors.white,
          side: BorderSide(
              color:
                  _selectedPlumbing ? Color(0xFF005792) : Colors.grey.shade400,
              width: _selectedPlumbing ? 1.5 : 1.5),
          onSelected: (bool selected) {
            setState(() {
              _selectedPlumbing = !_selectedPlumbing;
            });
          });
    }));
  }

  static Widget others(double choicesize) {
    return StatefulBuilder(builder: ((context, setState) {
      return ChoiceChip(
          selected: _selectedOthers,
          label: SizedBox(
            width: choicesize,
            child: Text('Others',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),textAlign: TextAlign.center,),
          ),
          labelStyle: TextStyle(
            color: _selectedOthers ? Colors.white : Colors.grey.shade400,
          ),
          disabledColor: Colors.white,
          selectedColor: Color(0xFF005792),
          backgroundColor: Colors.white,
          side: BorderSide(
              color: _selectedOthers ? Color(0xFF005792) : Colors.grey.shade400,
              width: _selectedOthers ? 1.5 : 1.5),
          onSelected: (bool selected) {
            setState(() {
              _selectedOthers = !_selectedOthers;
            });
          });
    }));
  }
}
