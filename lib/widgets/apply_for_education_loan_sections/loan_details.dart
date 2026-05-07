import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/widgets/input_field.dart';

class LoanDetails extends StatelessWidget {
  Function updateSection;
  LoanDetails({super.key, required this.updateSection});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          key: const ValueKey(2),
          children: [
            InputField(title: "Loan Amount"),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: kPrimaryButtonStyle,
                    onPressed: () {
                      updateSection(1);
                    },
                    child: const Text(
                      "Back",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: kAccentButtonStyle,
                    onPressed: () {},
                    child: const Text("Submit", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
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
