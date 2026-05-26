import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/widgets/feature_row_check.dart';
import 'package:student_cover/widgets/insurance_flow_widgets/apply_for_insurance.dart';
import 'package:student_cover/widgets/insurance_flow_widgets/insurance_api_part.dart';
import 'package:student_cover/widgets/quick_tools.dart';
import 'package:student_cover/widgets/screen_app_bar.dart';
import 'package:student_cover/widgets/study_destinations.dart';
import 'package:student_cover/widgets/testimonials.dart';
import 'package:student_cover/widgets/top_universities.dart';
import 'package:student_cover/widgets/trusted_by.dart';

class HealthInsuranceFlow extends StatefulWidget {
  static final String screenName = "HealthInsuranceFlow";
  const HealthInsuranceFlow({super.key});

  @override
  State<HealthInsuranceFlow> createState() => _HealthInsuranceFlowState();
}

class _HealthInsuranceFlowState extends State<HealthInsuranceFlow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getScreenAppBar("Health Insurance"),
      body: ListView(
        children: [
          ApplyForInsurance(),
          SizedBox(height: 24),
          InsuranceAIChat(),
          SizedBox(height: 24),
          TopUniversities(),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: QuickTools(showAdmissionCounsellingTools: false, showELTools: false, showHealthInsuranceTools: true),
          ),
          SizedBox(height: 24),
          TrustedBy(),
        ],
      ),
    );
  }
}
