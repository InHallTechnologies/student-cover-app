import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';

class EventRegistrations extends StatefulWidget {
  static final String screenName = "EventRegistration";
  Map event;
  EventRegistrations({super.key, required this.event});

  @override
  State<EventRegistrations> createState() => _EventRegistrationsState();
}

class _EventRegistrationsState extends State<EventRegistrations> {
  @override
  void initState() {
    super.initState();
    debugPrint(widget.event.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Background image — must be painted FIRST (below the filter)
                SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: Image.network(widget.event['eventImage'], fit: BoxFit.cover),
                ),
                // BackdropFilter blurs everything painted behind it
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(color: Colors.transparent),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Hero(
                    tag: "event_id_${widget.event['eventName']}",
                    child: Image.network(widget.event['eventImage'], fit: BoxFit.fitWidth, height: 200),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
