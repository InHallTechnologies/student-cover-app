import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';

class InsuranceAIChat extends StatelessWidget {
  const InsuranceAIChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Know Your Insurance", style: kHeadlineStyle.copyWith(color: textPrimary)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: kDefaultCardDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: kPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.smart_toy_rounded, color: kPrimary, size: 28),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AI Policy Assistant",
                            style: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text("Upload & ask questions about your policy", style: TextStyle(color: textSecondary, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    dashPattern: const [8, 4],
                    strokeWidth: 1.5,
                    padding: const EdgeInsets.all(24),
                    radius: const Radius.circular(16),
                  ),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Icon(Icons.cloud_upload_outlined, color: kPrimary, size: 40),
                        SizedBox(height: 12),
                        Text(
                          "Upload Policy Document",
                          style: TextStyle(color: textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 4),
                        Text("Upload PDF or Image (Max 10MB)", style: TextStyle(color: textSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Try asking:",
                  style: TextStyle(color: textPrimary, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _buildQuestionChip("What is my deductible?"),
                const SizedBox(height: 8),
                _buildQuestionChip("Does my plan cover mental health?"),
                const SizedBox(height: 8),
                _buildQuestionChip("How do I file a claim?"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          const Icon(Icons.chat_bubble_outline, color: kPrimaryLight, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: textPrimary, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
