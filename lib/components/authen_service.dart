import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helpee/models/user_models.dart';

import '../main.dart';

Future<Null> findNameAndEmail() async {
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      // displayName = event!.displayName!;
      // print("DisplayName : " + displayName);
      var displayName = FirebaseAuth.instance.currentUser!.displayName!;
      print("### Display Name : " + displayName);
    });
  });
}

int check() {
  loginCheck();
  if (loginKey == 0) {
    loginKey = 0;
  } else {
    loginKey = 1;
  }

  return loginKey;
}

Future<Null> loginCheck() async {
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
        loginKey = 0;
      } else {
        print('User is signed in! ${user.displayName}');
        loginKey = 1;
      }
      print(loginKey != null ? '==> LoginKey : $loginKey' : "Empty");
    });
  });
}

List<String> docIDs = [];

Future getDocId() async {
  await FirebaseFirestore.instance
      .collection('user')
      .get()
      .then((snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }));
}

// Future<Null> processSignInGoogle() async {
//   late String email, password, name, uid;
//   print(" # Logging in ... #");
//   GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//       'https://www.googleapis.com/auth/contacts.readonly',
//     ],
//   );

//   await Firebase.initializeApp().then((value) async {
//     await _googleSignIn.signIn().then((value) async {
//       name = value!.displayName!;
//       email = value.email;

//       await value.authentication.then((value2) async {
//         AuthCredential authCredential = GoogleAuthProvider.credential(
//           idToken: value2.idToken,
//           accessToken: value2.accessToken,
//         );
//         await FirebaseAuth.instance
//             .signInWithCredential(authCredential)
//             .then((value3) async {
//           uid = value3.user!.uid;
//           print(
//               " # Login With Gmail Success With name = $name, email = $email, uid =$uid #");
//           insertValueToCloudFirestore();

//           // await FirebaseFirestore.instance
//           //     .collection('user')
//           //     .doc(uid)
//           //     .snapshots()
//           //     .listen((event) {
//           //   print('event ==> ${event.data()}');
//           //   if (event.data() == null) {
//           //     // Call TypeUser
//           //   } else {
//           //     // Route to Service by TypeUser
//           //   }
//           // });
//           Navigator.pop(context);
//         });
//       });
//     });
//   });
// }

// Future<Null> insertValueToCloudFirestore() async {
//   UserModel user = UserModel(email: email, name: name);
//   Map<String, dynamic> data = user.toMap();
//   await Firebase.initializeApp().then((value) async {
//     await FirebaseFirestore.instance
//         .collection('user')
//         .doc(uid)
//         .set(data)
//         .then((value) {
//       print(' # Insert Value To Firestore Success Email= $email #');
//       // Navigator
//     });
//   });
// }
