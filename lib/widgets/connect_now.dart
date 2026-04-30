import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';

class ConnectNow extends StatelessWidget {
  const ConnectNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: kCtaBoxDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.support_agent_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Need Help?", style: kCtaHeadlineStyle),
                SizedBox(height: 4),
                Text("Connect with our experts now!", style: kCtaSubheadlineStyle),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: kAccentButtonStyle,
            child: const Text("Call Now", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
