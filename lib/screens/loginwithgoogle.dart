import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helpee/models/user_models.dart';
import 'package:helpee/main.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({super.key});

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

// class FirstRoute extends StatelessWidget {
//   const FirstRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('First Route'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: const Text('Open route'),
//           onPressed: () {
//             // Navigate to second route when tapped.
//           },
//         ),
//       ),
//     );
//   }
// }

// class SecondRoute extends StatelessWidget {
//   const SecondRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Second Route'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Navigate back to first route when tapped.
//           },
//           child: const Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  late String email, password, name, uid;

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

            // redirect

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

            //Navigator.pop(context);
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

        /*----------- redirect ---------*/
        // Navigator
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
        );
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => NavScreen()));
      });
    });
  }

  Widget textLabel(String nametext) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Text(nametext,
          style: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
    );
  }

  Widget googleButton() {
    return ElevatedButton(
      onPressed: processSignInGoogle,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          // side: BorderSide(color: Colors.black54, width: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image(
              image: AssetImage("assets/images/google.png"),
              width: 22,
              height: 22,
            ),
          ),
          Text("Log in with Google",
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Scaffold(
          backgroundColor: Color(0xFF005792),
          /* ----------------- App Bar ---------------- */
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFF005792),
            foregroundColor: Colors.white,
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Image.asset("assets/images/helpee1.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Welcome to Helpee",
                              style: GoogleFonts.montserrat(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Application for help in various fields",
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text("Continue with Google",
                      //         style: GoogleFonts.montserrat(
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w500,
                      //             color: Colors.white)),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 50),
                        child: SizedBox(height: 44, child: googleButton()),
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

Widget NavScreen() {
  return TextField(
    keyboardType: TextInputType.text,
    cursorColor: Colors.grey,
    style: GoogleFonts.montserrat(
        fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
    decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.search_outlined,
          color: Colors.grey.shade400,
        ),
        hintText: 'Search',
        hintStyle: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade400),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        filled: true,
        fillColor: Colors.grey.shade100,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Colors.grey.shade100),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Colors.grey.shade100),
            borderRadius: BorderRadius.circular(10))),
  );
}
