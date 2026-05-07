import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';

class FeatureCheckRow extends StatelessWidget {
  final String title;
  const FeatureCheckRow({super.key, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Icon(Icons.check, color: accentLight),
        Text(title, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
