import 'package:flutter/material.dart';
import 'package:student_cover/screens/education_loan_flow.dart';
import 'package:student_cover/screens/health_insurance_flow.dart';

class ServiceSelector extends StatelessWidget {
  const ServiceSelector({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = ((screenWidth - 32) / 2) - 8;

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        ServiceItem(
          itemWidth: itemWidth,
          title: "Education Loan",
          subTitle: "₹12,50,000\napproved",
          label: "ACTIVE",
          icon: Icons.school,
          iconColor: const Color(0xFF1E60E6),
          iconBgColor: const Color(0xFFE8F1FF),
          labelColor: const Color(0xFF1EA952),
          labelBgColor: const Color(0xFFE6F8ED),
          context: context,
          routeTo: EducationLoanFlow.screenName,
        ),
        ServiceItem(
          itemWidth: itemWidth,
          title: "Health\nInsurance",
          subTitle: "Valid till Dec 2024",
          label: "COVERED",
          icon: Icons.favorite,
          iconColor: const Color(0xFFE31B54),
          iconBgColor: const Color(0xFFFFF0F5),
          labelColor: const Color(0xFF1E60E6),
          labelBgColor: const Color(0xFFE8F1FF),
          context: context,
          routeTo: HealthInsuranceFlow.screenName,
        ),
        ServiceItem(
          itemWidth: itemWidth,
          title: "Admission\nCounselling",
          subTitle: "Expert guidance",
          label: "READY",
          icon: Icons.explore,
          iconColor: const Color(0xFF9036F5),
          iconBgColor: const Color(0xFFF6F0FF),
          labelColor: const Color(0xFFE68A00),
          labelBgColor: const Color(0xFFFFF5E6),
          context: context,
          routeTo: EducationLoanFlow.screenName,
        ),
        ServiceItem(
          itemWidth: itemWidth,
          title: "Travel\nInsurance",
          subTitle: "Secure your journey",
          label: "Apply",
          icon: Icons.description,
          iconColor: const Color(0xFF4B6BF5),
          iconBgColor: const Color(0xFFF0F5FA),
          labelColor: const Color(0xFF4B5563),
          labelBgColor: const Color(0xFFF3F4F6),
          context: context,
          routeTo: EducationLoanFlow.screenName,
        ),
      ],
    );
  }

  Widget ServiceItem({
    required double itemWidth,
    required String title,
    required String subTitle,
    required String label,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required Color labelColor,
    required Color labelBgColor,
    required String routeTo,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeTo);
      },
      child: Container(
        width: itemWidth,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
                  child: Icon(icon, color: iconColor, size: 28),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: labelBgColor, borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    label,
                    style: TextStyle(color: labelColor, fontSize: 12, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, height: 1.25, color: Color(0xFF1E2A5A)),
            ),
            const SizedBox(height: 8),
            Text(subTitle, style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.4)),
          ],
        ),
      ),
    );
  }
}
