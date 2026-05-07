import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/screens/apply_for_insurance.dart';
import 'package:student_cover/widgets/feature_row_check.dart';

class ApplyForInsurance extends StatelessWidget {
  const ApplyForInsurance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
              tag: "health_insurance_apply_now_sc_logo",
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
                      child: const Icon(Icons.health_and_safety, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(child: Text("Get Protected Today", style: kHeroHeadlineStyle)),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Compare plans from top providers and find the perfect coverage for your study abroad journey",
                  style: kHeroSubheadlineStyle,
                ),
                const SizedBox(height: 12),
                const FeatureCheckRow(title: "Instant quotes from 15+ insurers"),
                const FeatureCheckRow(title: "Coverage from \$50,000 to \$500,000"),
                const FeatureCheckRow(title: "24/7 claim support"),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CompareAndApplyInsurance.screenName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text("Compare & Apply Now", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
