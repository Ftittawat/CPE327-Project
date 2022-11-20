import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
