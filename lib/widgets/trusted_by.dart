import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';

class TrustedBy extends StatelessWidget {
  const TrustedBy({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 8,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("images/trusted_by.png", fit: BoxFit.cover),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Text(
                "Trusted by 20k+ Students Worldwide",
                style: kHeadlineStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: kPrimaryDark),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
