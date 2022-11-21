import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helpee/components/dialog.dart';
import 'package:helpee/components/utils.dart';

import 'package:helpee/models/user_models.dart';
import 'package:helpee/providers/google_sign_in.dart';
import 'package:helpee/screens/login.dart';
import 'package:helpee/pages/profilePage.dart';
import 'package:provider/provider.dart';

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

  late String email, password, name, uid, typeUser;

  Widget textLabel(String nametext) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Text(nametext,
          style: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
    );
  }

  Widget emailBox() {
    return TextFormField(
      onChanged: (value) => email = value.trim(),
      validator: MultiValidator([
        EmailValidator(errorText: "Please fill the e-mail fommat"),
        RequiredValidator(errorText: "Please enter your email"),
      ]),
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      cursorColor: Color(0xFF005792),
      decoration: InputDecoration(
          // hintText: 'E-mail',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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

  Widget usernamebox() {
    return TextFormField(
      onChanged: (value) => name = value.trim(),
      validator: RequiredValidator(errorText: "Please enter name"),
      controller: usernameController,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      cursorColor: Color(0xFF005792),
      decoration: InputDecoration(

          // hintText: 'Username',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),

          hintText: 'Name',
          hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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

  Widget phonebox() {
    return TextFormField(
      validator: RequiredValidator(errorText: "Please enter phone"),
      controller: phoneController,
      keyboardType: TextInputType.phone,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      cursorColor: Color(0xFF005792),
      decoration: InputDecoration(
          // hintText: 'Phone',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
      onChanged: (value) => password = value.trim(),
      validator: RequiredValidator(errorText: "Please enter password"),
      controller: passwordController,
      obscureText: _isObscuredpassword,
      keyboardType: TextInputType.visiblePassword,
      style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      cursorColor: Color(0xFF005792),
      decoration: InputDecoration(
          // hintText: 'Password',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
      cursorColor: Color(0xFF005792),
      decoration: InputDecoration(
          // hintText: 'Confirm Password',
          // hintStyle: GoogleFonts.montserrat(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return Login();
          }));
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
              onPressed:
                  processSignInGoogle /*() {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              }*/
              ,
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

  Widget signupButton() {
    return ElevatedButton(
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

  // Future<Null> createAccountAndInsertInformation() async {
  //   await Firebase.initializeApp().then((value) async {
  //     print("## Firebase Initialize Success ##");
  //     await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //             email: emailController.text.trim(),
  //             password: passwordController.text.trim())
  //         .then((value) => print('Create Account Success'))
  //         .catchError((onError) =>
  //             normalDialog(context, onError.code, onError.message));
  //   });
  // }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) async {
        String uid = value.user!.uid;
        print("## uid = $uid");
        UserModel user = UserModel(
            email: emailController.text.trim(),
            name: usernameController.text.trim());
        Map<String, dynamic> data = user.toMap();
        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .set(data)
            .then((value) {
          print(' # Insert Value To Firestore Success');
          // Navigator
        });
        print(" # Create Account Success With email = $email, uid = $uid # ");
      });
      Fluttertoast.showToast(
          msg: "Account has been created", gravity: ToastGravity.CENTER);

      emailController.clear();
      usernameController.clear();

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
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
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: textLabel('E-mail')),
                                  emailBox(),
                                ],
                              ),
                            ),

                            // Padding(
                            //   padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            //   child: Column(
                            //     children: [
                            //       Align(
                            //           alignment: Alignment.centerLeft,
                            //           child: textLabel('Username')),
                            //       usernamebox(),
                            //     ],
                            //   ),
                            // ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: usernamebox(),
                            ),

                            // Padding(
                            //   padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            //   child: Column(
                            //     children: [
                            //       Align(
                            //           alignment: Alignment.centerLeft,
                            //           child: textLabel('Phone')),
                            //       phonebox(),
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: textLabel('Password')),
                                  passwordBox(),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            //   child: Column(
                            //     children: [
                            //       Align(
                            //           alignment: Alignment.centerLeft,
                            //           child: textLabel('Confirm Password')),
                            //       passwordConfirmBox(),
                            //     ],
                            //   ),
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
