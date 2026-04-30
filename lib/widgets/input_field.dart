import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final String title;

  const InputField({super.key, this.hintText = "", required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              title,
              style: const TextStyle(color: textPrimary, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.3),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 2))],
            ),
            child: TextField(
              style: const TextStyle(color: textPrimary, fontSize: 15, fontWeight: FontWeight.w500),
              cursorColor: kPrimary,
              decoration: kAuthenticationInputDecoration.copyWith(
                isDense: true,
                hintText: hintText.isNotEmpty ? hintText : "Enter $title",
                hintStyle: const TextStyle(color: textSecondary, fontSize: 14, fontWeight: FontWeight.w400),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                prefixIcon: const SizedBox.shrink(),
                prefixIconConstraints: const BoxConstraints(minWidth: 16, minHeight: 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
