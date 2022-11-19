import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helpee/screens/register.dart';

import '../models/user_models.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

const darkblue = Color(0xFF005792);

class _LoginState extends State<Login> {

  Widget textLabel(String nametext) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Text(nametext,
          style: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
    );
  }

  final formKey = GlobalKey<FormState>();
  late String email, password, name, uid;


  Widget emailBox() {
    return TextFormField(
      validator: MultiValidator([
        EmailValidator(errorText: "Please fill the e-mail fommat"),
        RequiredValidator(errorText: "Please enter your email"),
      ]),
      onChanged: (value) => email = value.trim(),
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      cursorColor: Color(0xFF005792),
      decoration: InputDecoration(
          // hintText: 'E-mail',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Color(0xFF005792)),
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
      validator: RequiredValidator(errorText: "Please enter password"),
      onChanged: (value) => password = value.trim(),
      obscureText: _isObscured,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      cursorColor: Color(0xFF005792),
      decoration: InputDecoration(
          // hintText: 'Password',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Color(0xFF005792)),
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
      onPressed: signIn,
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

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await Firebase.initializeApp().then((value) async {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Fluttertoast.showToast(
              msg: "Login Success", gravity: ToastGravity.CENTER);
          Navigator.pop(context);
        }).catchError((value) => Fluttertoast.showToast(
                msg: value.message, gravity: ToastGravity.CENTER));
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
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
              onPressed: processSignInGoogle,
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

  Future<Null> processSignInGoogle() async {
    print(" # Logging in ... #");
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    await Firebase.initializeApp().then((value) async {
      await _googleSignIn.signIn().then((value) async {
        name = value!.displayName!;
        email = value.email;

        await value.authentication.then((value2) async {
          AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: value2.idToken,
            accessToken: value2.accessToken,
          );
          await FirebaseAuth.instance
              .signInWithCredential(authCredential)
              .then((value3) async {
            uid = value3.user!.uid;
            print(
                " # Login With Gmail Success With name = $name, email = $email, uid =$uid #");
            insertValueToCloudFirestore();

            // await FirebaseFirestore.instance
            //     .collection('user')
            //     .doc(uid)
            //     .snapshots()
            //     .listen((event) {
            //   print('event ==> ${event.data()}');
            //   if (event.data() == null) {
            //     // Call TypeUser
            //   } else {
            //     // Route to Service by TypeUser
            //   }
            // });
            Navigator.pop(context);
          });
        });
      });
    });
  }

  Future<Null> insertValueToCloudFirestore() async {
    UserModel user = UserModel(email: email, name: name);
    Map<String, dynamic> data = user.toMap();
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .set(data)
          .then((value) {
        print(' # Insert Value To Firestore Success Email= $email #');
        // Navigator
      });
    });
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
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
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
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: textLabel('E-mail')),
                            emailBox(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: textLabel('Password')),
                            passwordBox(),
                          ],
                        ),
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
