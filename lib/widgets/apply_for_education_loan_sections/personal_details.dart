import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/widgets/input_field.dart';

class PersonalDetails extends StatelessWidget {
  Function updateSection;
  PersonalDetails({super.key, required this.updateSection});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Column(
        key: const ValueKey(0),
        children: [
          InputField(title: "Full Name"),
          InputField(title: "Phone Number", hintText: "91 xxxxxxxxxx"),
          InputField(title: "Email Id"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: kAccentButtonStyle,
                onPressed: () {
                  updateSection(1);
                },
                child: const Text("Next", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
