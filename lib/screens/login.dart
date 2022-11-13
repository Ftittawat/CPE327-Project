import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/screens/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

const darkblue = Color(0xFF005792);

class _LoginState extends State<Login> {
  Widget emailBox() {
    return TextField(
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      cursorColor: Color(0xFF005792),
      decoration: InputDecoration(
          hintText: 'E-mail',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
    );
  }

  var _isObscured;
  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  Widget passwordBox() {
    return TextFormField(
      obscureText: _isObscured,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      cursorColor: Color(0xFF005792),
      decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10)),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
              icon: _isObscured
                  ? Icon(
                      Icons.visibility_outlined,
                      color: Colors.grey.shade400,
                    )
                  : Icon(Icons.visibility_off_outlined,
                      color: Colors.grey.shade400))),
    );
  }

  Widget signinButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF005792),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sign In",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ],
      ),
    );
  }

  Widget forgetpasswordbutton() {
    return TextButton(
        onPressed: () {},
        child: Text("Forgot password",
            style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF005792))));
  }

  Widget signupbutton() {
    return TextButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return Register();
          }));
        },
        child: Text("Sign Up",
            style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF005792))));
  }

  Widget ortext() {
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: (MediaQuery.of(context).size.width / 2) - 30,
            child: Divider(
                height: 10,
                indent: 10,
                endIndent: 10,
                thickness: 2,
                color: Colors.black),
          ),
          Text("Or",
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          SizedBox(
            width: (MediaQuery.of(context).size.width / 2) - 30,
            child: Divider(
                height: 10,
                thickness: 2,
                indent: 10,
                endIndent: 10,
                color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget otherlogin() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: CircleBorder(),
                padding: EdgeInsets.all(8),
                elevation: 0.0,
              ),
              child: Image(image: AssetImage("assets/images/google.png")),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: CircleBorder(),
                padding: EdgeInsets.all(8),
                elevation: 0.0,
              ),
              child: Image(image: AssetImage("assets/images/facebook.png")),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Scaffold(
          backgroundColor: Colors.white,
          /* ----------------- App Bar ---------------- */
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF005792),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        child: Text("Sign In",
                            style: GoogleFonts.montserrat(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                        child: emailBox(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                        child: passwordBox(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: SizedBox(
                          height: 30.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              forgetpasswordbutton(),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SizedBox(
                          height: 55.0,
                          child: signinButton(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Don’t have an account?",
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                            SizedBox(
                              height: 30.0,
                              child: signupbutton(),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: ortext(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: otherlogin(),
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
