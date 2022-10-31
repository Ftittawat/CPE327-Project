import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notificationscreen extends StatefulWidget {
  const Notificationscreen({super.key});

  @override
  State<Notificationscreen> createState() => _NotificationscreenState();
}

const darkblue = Color(0xFF005792);

class _NotificationscreenState extends State<Notificationscreen> {
  Widget notificationtext(
      String notiTitle, String notiDescription, String notiTime) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Icon(
                      Icons.notifications_active,
                      size: 20,
                      color: Color(0xFF005792),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                  width: MediaQuery.of(context).size.width - 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notiTitle,
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      Text(notiDescription,
                          style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                      Text("$notiTime minutes ago",
                          style: GoogleFonts.montserrat(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: 2.0,
              color: Colors.grey.shade400,
            )
          ],
        ),
      ),
    );
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
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: notificationtext(
                        'Your request has been assisted.',
                        'Your TV installation request has been assisted.',
                        '15'),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: notificationtext(
                        'Your request has been assisted.',
                        'Your TV installation request has been assisted.',
                        '15'),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: notificationtext(
                        'Your request has been assisted.',
                        'Your TV installation request has been assisted.',
                        '15'),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: notificationtext(
                        'Your request has been assisted.',
                        'Your TV installation request has been assisted.',
                        '15'),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

