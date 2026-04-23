import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';

class StatusAndReminders extends StatelessWidget {
  const StatusAndReminders({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        "title": "Application Submitted",
        "time": "Today, 10:30 AM",
        "description":
            "Your education loan application is currently under review by our partners.",
      },
      {
        "title": "Document Required",
        "time": "Yesterday, 04:15 PM",
        "description":
            "Action needed: Please upload your latest mark sheets to proceed.",
      },
      {
        "title": "Profile Verified",
        "time": "Mar 12, 09:00 AM",
        "description":
            "Your student profile has been successfully verified securely.",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        const Text(
          "Status & Reminders",
          style: TextStyle(
            color: textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: cardBackground,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: List.generate(notifications.length, (index) {
              final item = notifications[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < notifications.length - 1 ? 24 : 0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryLight,
                        boxShadow: [
                          BoxShadow(
                            color: kGreyColor.withOpacity(0.4),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item["title"]!,
                                style: TextStyle(
                                  color: index == 0
                                      ? textPrimary
                                      : textPrimary.withOpacity(0.7),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                item["time"]!,
                                style: const TextStyle(
                                  color: textSecondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item["description"]!,
                            style: const TextStyle(
                              color: textSecondary,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
