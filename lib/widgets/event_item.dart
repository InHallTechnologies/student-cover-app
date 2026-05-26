import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/screens/event_registration.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.event});
  final dynamic event;

  void handleTap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EventRegistrations(event: event)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => handleTap(context),
      child: Container(
        margin: const EdgeInsets.only(right: 14),
        width: 330,
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: border),
          boxShadow: [BoxShadow(color: kPrimary.withOpacity(0.08))],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 8,
                  child: Hero(
                    tag: "event_id_${event['eventName']}",
                    child: Image.network(event['eventBanner'], fit: BoxFit.cover),
                  ),
                ),

                Positioned.fill(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, kPrimaryDark.withOpacity(0.55)],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: kPrimaryLight, borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      event['eventDate'][0],
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.3),
                    ),
                  ),
                ),
              ],
            ),
            // Event details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event name
                    Text(
                      event['eventName'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: kPrimary, fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: 0.2, height: 1.3),
                    ),
                    SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        event['paragraphAbout'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: textSecondary, fontSize: 12, fontWeight: FontWeight.w400, height: 1.5),
                      ),
                    ),

                    // Duration chip
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 12,
                      children: [
                        _InfoChip(
                          icon: Icons.access_time_rounded,
                          label: event['eventDuration'],
                          iconColor: textSecondary,
                          textColor: textSecondary,
                          bgColor: Color(0xFFF3F4F6),
                        ),

                        // Location chip
                        _InfoChip(
                          icon: Icons.location_on_rounded,
                          label: event['eventLocation'].join(", "),
                          iconColor: accent,
                          textColor: accent,
                          bgColor: accent.withOpacity(0.08),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label, required this.iconColor, required this.textColor, required this.bgColor});

  final IconData icon;
  final String label;
  final Color iconColor;
  final Color textColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: iconColor),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
