import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/category.dart';
import 'package:helpee/screens/showallrequest.dart';

class GetMyRequests extends StatelessWidget {
  final String documentID;

  GetMyRequests({required this.documentID});

  @override
  Widget build(BuildContext context) {
    // get the collection
    CollectionReference users =
        FirebaseFirestore.instance.collection('Request');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Card(
            child: ListTile(
                /* ----------------- Title ---------------- */
                title: Text(
                  "Topic: ${data['Topic']}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF005792)),
                ),
                subtitle: Column(
                  children: [
                    /* ----------------- Category ---------------- */
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Category.tag('${data['category']}'),
                      ),
                    ),
                    /* ----------------- Subtitle ---------------- */
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Text(
                        // "Subtitle: ${data['subtitle']}",
                        "Subtitle: ${data['Descrition']}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    /* ----------------- Distance ---------------- */
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            /* ----------------- Distance Icon ---------------- */
                            Icon(
                              Icons.location_on_outlined,
                              size: 18,
                              color: Colors.black,
                            ),
                            /* ----------------- Distance Text ---------------- */
                            Text(
                              "Distance ${data['distance']} kilometers.",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /* ----------------- Date Time ---------------- */
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "22 Oct 2022, 10:22",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: Icon(Icons.person),
                isThreeLine: true,
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         ShowAllRequestScreen(listRequest: documentID),
                  //   ),
                  // );
                }),
          );
        }
        return Text('loading...');
      }),
    );
  }
}
