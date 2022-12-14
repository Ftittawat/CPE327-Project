import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpee/models/ListNotification.dart';
import 'package:helpee/screens/showNotification.dart';

import '../components/authen_service.dart';

class Notificationscreen extends StatefulWidget {
  const Notificationscreen({super.key});

  @override
  State<Notificationscreen> createState() => _NotificationscreenState();
}

const darkblue = Color(0xFF005792);

class _NotificationscreenState extends State<Notificationscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("--- ### Notification ### ---");

    int checkKey = check();
    print("Check = " + checkKey.toString());
  }

  /* group data */
  List<ListNotification> listnotification = [
    ListNotification(1, "Request accepted.", "Your request has been assisted."),
    ListNotification(2, "Request Created.", "Your request has been created."),
    ListNotification(
        3, "Request Successfully.", "Your request has been successfully."),
    ListNotification(
        4, "New Version Update.", "Application has new version update"),
    ListNotification(1, "Request accepted.", "Your has been assisted."),
    ListNotification(2, "Request Created.", "Your request has been created."),
    ListNotification(
        3, "Request Successfully.", "Your request has been successfully."),
    ListNotification(
        4, "New Version Update.", "Application has new version update"),
    ListNotification(1, "Request accepted.", "Your has been assisted."),
    ListNotification(2, "Request Created.", "Your request has been created."),
    ListNotification(
        3, "Request Successfully.", "Your request has been successfully."),
    ListNotification(
        4, "New Version Update.", "Application has new version update"),
  ];

  String notiurl(int notityoe) {
    var url;
    if (notityoe == 1) {
      url = 'assets/images/bell.png';
    } else if (notityoe == 2) {
      url = 'assets/images/sos.png';
    } else if (notityoe == 3) {
      url = 'assets/images/checked.png';
    } else if (notityoe == 4) {
      url = 'assets/images/warning.png';
    }
    return url;
  }

  Widget cancelButton() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  title: Text("Delete",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF005792)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF005792)),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(Icons.delete_outlined),
          iconSize: 20,
          splashRadius: 15,
          color: Colors.grey.shade400,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Notification",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView.builder(
            itemCount: listnotification.length,
            itemBuilder: (BuildContext context, int index) {
              ListNotification notification = listnotification[index];
              return Card(
                // elevation: 0,
                child: ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    leading: SizedBox(
                        height: 17,
                        width: 17,
                        child: Image(
                            image: AssetImage(notiurl(notification.type)))),
                    title: Text(
                      notification.title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF005792)),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            "15 minutes ago",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: cancelButton(),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowNotificationScreen(
                              listNotification: notification),
                        ),
                      );
                    }),
              );
            },
          ),
        ),
      ),
    );
  }
}
