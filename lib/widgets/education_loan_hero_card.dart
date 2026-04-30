import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/screens/apply_for_education_loan.dart';

class EducationLoanHeroCard extends StatelessWidget {
  const EducationLoanHeroCard({super.key});

  Row FeatureCheckRow(String value) {
    return Row(
      spacing: 12,
      children: [
        Icon(Icons.check, color: accentLight),
        Text(value, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: const RadialGradient(colors: [gradientStart, gradientEnd]),
        boxShadow: [BoxShadow(color: gradientStart.withOpacity(0.3), blurRadius: 5, offset: const Offset(0, 0))],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -200,
            top: -20,
            child: Hero(
              tag: "education_loan_apply_now_sc_logo",
              child: Opacity(opacity: 0.2, child: Image.asset("images/student_cover_logo_only_white.png", height: 600)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.school, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(child: Text("Education Loan", style: kHeroHeadlineStyle)),
                  ],
                ),
                const SizedBox(height: 20),
                const Text("Get education loans up to ₹1 Crore with competitive interest rates starting from 8.5%", style: kHeroSubheadlineStyle),
                const SizedBox(height: 12),
                FeatureCheckRow("No Collatral Required"),
                FeatureCheckRow("15+ Years in the business"),
                FeatureCheckRow("No Hidden Changes"),
                FeatureCheckRow("No Hidden Changes"),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ApplyForEducationLoan.screenName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text("Apply For Loan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
