import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';

class QuickTools extends StatelessWidget {
  const QuickTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        const Text(
          "Quick Tools",
          style: TextStyle(
            color: textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 20),

        QuickItemServices(
          sectionTitle: "Education Loan",
          accentColor: const Color(0xFF1E60E6),
          iconBgColor: const Color(0xFFE8F1FF),
          tools: const [
            {"toolTitle": "EMI Calc", "iconData": Icons.calculate},
            {"toolTitle": "Interest", "iconData": Icons.percent},
            {"toolTitle": "Repayment", "iconData": Icons.account_balance_wallet},
            {"toolTitle": "Eligibility", "iconData": Icons.fact_check},
          ],
        ),
        const SizedBox(height: 24),

        QuickItemServices(
          sectionTitle: "Health Insurance",
          accentColor: const Color(0xFFE31B54),
          iconBgColor: const Color(0xFFFFF0F5),
          tools: const [
            {"toolTitle": "Claim", "iconData": Icons.health_and_safety},
            {"toolTitle": "Hospitals", "iconData": Icons.local_hospital},
            {"toolTitle": "Policy", "iconData": Icons.description},
            {"toolTitle": "Support", "iconData": Icons.support_agent},
          ],
        ),
        const SizedBox(height: 24),

        QuickItemServices(
          sectionTitle: "Admission Counselling",
          accentColor: const Color(0xFF9036F5),
          iconBgColor: const Color(0xFFF6F0FF),
          tools: const [
            {"toolTitle": "Varsities", "iconData": Icons.account_balance},
            {"toolTitle": "Courses", "iconData": Icons.menu_book},
            {"toolTitle": "Mentors", "iconData": Icons.co_present},
            {"toolTitle": "Status", "iconData": Icons.track_changes},
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class QuickItemServices extends StatelessWidget {
  final String sectionTitle;
  final List tools;
  final Color accentColor;
  final Color iconBgColor;

  const QuickItemServices({
    super.key,
    required this.sectionTitle,
    required this.tools,
    required this.accentColor,
    required this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              sectionTitle,
              style: const TextStyle(
                color: textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: ListView.separated(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: tools.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final item = tools[index];
              return Container(
                width: 96,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item['iconData'],
                        color: accentColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item['toolTitle'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: textSecondary, // from constants.dart
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
