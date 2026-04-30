import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';

class StudyDestinations extends StatefulWidget {
  const StudyDestinations({super.key});

  @override
  State<StudyDestinations> createState() => _StudyDestinationsState();
}

class _StudyDestinationsState extends State<StudyDestinations> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [Text("Study Destinations", style: kHeadlineStyle.copyWith(color: kPrimaryDark))],
    );
  }
}
