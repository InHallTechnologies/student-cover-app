import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:slugify/slugify.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/widgets/screen_app_bar.dart';

class PlanList extends StatefulWidget {
  final String country;
  final String university;
  const PlanList({super.key, required this.country, required this.university});

  @override
  State<PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  List<String> _bestSeller = [];
  List<String> _plans = [];

  /// Which card indices are currently expanded
  final Set<int> _expandedCards = {};

  /// Number of detail pairs visible in the collapsed state
  static const int _collapsedPairs = 3;

  @override
  void initState() {
    super.initState();
    fetchPlans();
  }

  void fetchPlans() async {
    String slugifyCountry = slugify(widget.country, delimiter: "-");
    String slugifyUniversity = slugify(widget.university, delimiter: "-");
    final planList = await _firebaseDatabase
        .ref("HEALTH_PLANS_COUNTRY_WISE")
        .child(slugifyCountry)
        .child(slugifyUniversity)
        .once(DatabaseEventType.value);

    if (planList.snapshot.exists) {
      Map<Object?, Object?> planItem = planList.snapshot.value as Map;

      if (planItem.containsKey("bestsellers")) {
        List bestSeller = planItem['bestsellers'] as List;
        _bestSeller = List<String>.from(bestSeller);
      }

      if (planItem.containsKey("plans")) {
        List plans = planItem['plans'] as List;
        _plans = List<String>.from(plans);
      }
      setState(() {});
    }
  }

  // ── Builders ──────────────────────────────────────────────────────────────

  Widget _buildInfoCell(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(color: textSecondary, fontSize: 9, fontWeight: FontWeight.w600, letterSpacing: 0.8),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(color: textPrimary, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(List<List<String>> details) {
    final List<Widget> rows = [];
    for (int i = 0; i < details.length; i += 2) {
      final isLast = i + 1 >= details.length;
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildInfoCell(details[i][0], details[i][1])),
              if (!isLast) ...[
                VerticalDivider(width: 1, thickness: 1, color: border.withOpacity(0.6)),
                const SizedBox(width: 8),
                Expanded(child: _buildInfoCell(details[i + 1][0], details[i + 1][1])),
              ] else
                const Expanded(child: SizedBox()),
            ],
          ),
        ),
      );
      if (i + 2 < details.length) {
        rows.add(Divider(height: 1, thickness: 1, color: border.withOpacity(0.5)));
      }
    }
    return Column(children: rows);
  }

  // ── Screen ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final details = [
      ["Provider Network", "UHC"],
      ["Medical Sum Insured", "\$30,000.00"],
      ["Deductible", "\$100 Per injury or sickness"],
      ["Coverage Type", "Comprehensive"],
      ["Co-Insurance Ratio", "100:00"],
      ["In-patient/Out-patient", "Covered"],
      ["Medical Evaluation", "Upto Sum Insured"],
      ["Claim Type", "Direct Billing Or Reimbursement"],
      ["Prescription Drugs", "Covered"],
      ["Repatriation", "Upto \$50,000"],
      ["Student Health Care", "To be treated as any other provider"],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: getScreenAppBar("Plan List"),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
        children: [
          // ── Breadcrumb header ──
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 14, color: textSecondary),
              const SizedBox(width: 4),
              Text(
                widget.country,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: textSecondary),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Text("›", style: TextStyle(color: textSecondary, fontSize: 13)),
              ),
              Expanded(
                child: Text(
                  widget.university,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textPrimary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Divider(height: 20, thickness: 1, color: border),

          // ── Plan cards ──
          ListView.builder(
            itemCount: _plans.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final isExpanded = _expandedCards.contains(index);
              final visibleDetails = isExpanded ? details : details.take(_collapsedPairs * 2).toList();

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: cardBackground,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: border),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Plan name + price ──
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "SC Prima Plus",
                                style: TextStyle(color: kPrimaryDark, fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.1),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Health Insurance Plan",
                                style: TextStyle(fontSize: 11, color: textSecondary, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: kPrimary.withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "\$5,000.00",
                              style: TextStyle(color: kPrimary, fontSize: 14, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 1, thickness: 1, color: border),

                    // ── Animated detail grid ──
                    AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      child: Padding(padding: const EdgeInsets.fromLTRB(12, 2, 12, 2), child: _buildGrid(visibleDetails)),
                    ),

                    // ── View more / View less toggle ──
                    InkWell(
                      onTap: () => setState(() {
                        isExpanded ? _expandedCards.remove(index) : _expandedCards.add(index);
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F3F7),
                          border: Border(top: BorderSide(color: border)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isExpanded ? "View less" : "View more",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: kPrimary),
                            ),
                            const SizedBox(width: 4),
                            AnimatedRotation(
                              turns: isExpanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 250),
                              child: Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: kPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ── Enroll button ──
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: const WidgetStatePropertyAll(kPrimaryDark),
                            foregroundColor: const WidgetStatePropertyAll(Colors.white),
                            elevation: const WidgetStatePropertyAll(0),
                            padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 11)),
                            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          ),
                          child: const Text("Enroll Now", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.4)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
