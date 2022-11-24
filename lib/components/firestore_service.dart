// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:helpee/models/user_models.dart';

// class FirestoreService {
//   static Stream<List<UserModel>> read() {
//     final userCollection = FirebaseFirestore.instance.collection('user');
//     return userCollection.snapshots().map((querySnapshot) =>
//         querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
//   }

//   static Future create(UserModel user) async {
//     final userCollection = FirebaseFirestore.instance.collection('user');
//     final docRef = userCollection.doc();

//     final newUser = UserModel(
//       name: user.name,
//       email: user.email,
//     ).toJson();

//     try {
//       await docRef.set(newUser as Map<String, dynamic>);
//     } catch (e) {
//       print("some error $e");
//     }
//   }
// }
