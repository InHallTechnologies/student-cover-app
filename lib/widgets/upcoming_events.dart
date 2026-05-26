import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/widgets/event_item.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  bool _isLoading = true;
  final List _events = [];
  FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  void _fetchEvents() async {
    final eventsSnapshot = await _firebaseDatabase.ref("/EVENTS").limitToLast(10).once(DatabaseEventType.value);
    if (eventsSnapshot.snapshot.exists) {
      for (final eventId in eventsSnapshot.snapshot.children) {
        _events.add(eventId.value);
      }
    }
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Upcoming Events",
              style: TextStyle(color: textPrimary, fontSize: 22, fontWeight: FontWeight.w800),
            ),

            Row(children: [Text("View All"), Icon(Icons.arrow_right)]),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 320,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _events.length,
                  itemBuilder: (context, index) {
                    final event = _events[index];
                    return EventItem(event: event);
                  },
                ),
        ),
      ],
    );
  }
}
