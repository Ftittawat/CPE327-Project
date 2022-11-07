import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/components/utils.dart';
import 'package:helpee/models/profile.dart';
import 'package:helpee/screens/home.dart';
import 'package:helpee/screens/login.dart';
import 'package:helpee/screens/profile.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

const darkblue = Color(0xFF005792);

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final navigatorKey = GlobalKey<NavigatorState>();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _profilesCollection =
      FirebaseFirestore.instance.collection("profiles");
  //controller
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  Widget emailBox() {
    return TextFormField(
      validator: MultiValidator([
        EmailValidator(errorText: "Please fill the e-mail fommat"),
        RequiredValidator(errorText: "Please enter your email"),
      ]),
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          hintText: 'E-mail',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
    );
  }

  Widget usernamebox() {
    return TextFormField(
      validator: RequiredValidator(errorText: "Please enter username"),
      controller: usernameController,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          hintText: 'Username',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
    );
  }

  Widget phonebox() {
    return TextFormField(
      validator: RequiredValidator(errorText: "Please enter phone"),
      controller: phoneController,
      keyboardType: TextInputType.phone,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          hintText: 'Phone',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10))),
    );
  }

  var _isObscuredpassword;
  var _isObscuredconfirmpassword;
  @override
  void initState() {
    super.initState();
    _isObscuredpassword = true;
    _isObscuredconfirmpassword = true;
  }

  Widget passwordBox() {
    return TextFormField(
      validator: RequiredValidator(errorText: "Please enter password"),
      controller: passwordController,
      obscureText: _isObscuredpassword,
      keyboardType: TextInputType.visiblePassword,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10)),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isObscuredpassword = !_isObscuredpassword;
                });
              },
              icon: _isObscuredpassword
                  ? Icon(
                      Icons.visibility_outlined,
                      color: Colors.grey.shade400,
                    )
                  : Icon(Icons.visibility_off_outlined,
                      color: Colors.grey.shade400))),
    );
  }

  Widget passwordConfirmBox() {
    return TextFormField(
      validator: RequiredValidator(errorText: "Please enter password comfirm"),
      controller: confirmpasswordController,
      obscureText: _isObscuredconfirmpassword,
      keyboardType: TextInputType.visiblePassword,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
          hintText: 'Confirm Password',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xFF005792)),
              borderRadius: BorderRadius.circular(10)),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isObscuredconfirmpassword = !_isObscuredconfirmpassword;
                });
              },
              icon: _isObscuredconfirmpassword
                  ? Icon(
                      Icons.visibility_outlined,
                      color: Colors.grey.shade400,
                    )
                  : Icon(Icons.visibility_off_outlined,
                      color: Colors.grey.shade400))),
    );
  }

  Widget signinbutton() {
    return TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        child: Text("Sign In",
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

  Widget signupButton() {
    return ElevatedButton(
      // onPressed: () async {
      //   if (formKey.currentState!.validate()) {
      //     var email = emailController.text;
      //     var username = usernameController.text;
      //     var phone = phoneController.text;
      //     var password = passwordController.text;
      //     var confirmpassword = confirmpasswordController.text;

      //     Profiles statement = Profiles(
      //         email: email,
      //         username: username,
      //         phone: phone,
      //         password: password,
      //         confirmpassword: confirmpassword);

      //     print(statement.email);
      //     print(statement.username);
      //     print(statement.phone);
      //     print(statement.password);
      //     print(statement.confirmpassword);

      //     await _profilesCollection.add({
      //       "Email": statement.email,
      //       "Username": statement.username,
      //       "Phone": statement.phone,
      //       "Password": statement.password,
      //       "Confirmpassword": statement.confirmpassword
      //     });
      //     try {
      //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //           email: statement.email, password: statement.password);
      //       Fluttertoast.showToast(msg: "Account has been created");
      //       formKey.currentState!.reset();
      //     } on FirebaseAuthException catch (e) {
      //       print(e.message);
      //       print(e.code);

      //       Fluttertoast.showToast(
      //           msg: e.message.toString(), gravity: ToastGravity.CENTER);
      //     }
      //   }
      // },
      onPressed: signUp,
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF005792),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Create Account",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ],
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Fluttertoast.showToast(
          msg: "Account has been created", gravity: ToastGravity.CENTER);
      formKey.currentState!.reset();
      print("showDialog");
    } on FirebaseAuthException catch (e) {
      print(e);
      print("FirebaseAuthException");

      Utils.showSnackBar(e.message);
    }
    print("Test");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text("Error")),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 85,
                              child: Text("Sign Up",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: emailBox(),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            //   child: usernamebox(),
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            //   child: phonebox(),
                            // ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: passwordBox(),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            //   child: passwordConfirmBox(),
                            // ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                height: 55.0,
                                child: signupButton(),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Have an account?",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                  SizedBox(
                                    height: 30.0,
                                    child: signinbutton(),
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
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
