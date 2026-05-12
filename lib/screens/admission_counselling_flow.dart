import 'package:flutter/material.dart';
import 'package:student_cover/widgets/admission_counselling_sections/apply_for_admission_counselling.dart';
import 'package:student_cover/widgets/connect_now.dart';
import 'package:student_cover/widgets/screen_app_bar.dart';
import 'package:student_cover/widgets/testimonials.dart';
import 'package:student_cover/widgets/top_universities.dart';
import 'package:student_cover/widgets/trusted_by.dart';

class AdmissionCounsellingFlow extends StatefulWidget {
  static final String screenName = "AdmissionCounsellingFlow";
  const AdmissionCounsellingFlow({super.key});

  @override
  State<AdmissionCounsellingFlow> createState() => _AdmissionCounsellingFlowState();
}

class _AdmissionCounsellingFlowState extends State<AdmissionCounsellingFlow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getScreenAppBar("Admission Counselling"),
      body: ListView(
        children: [
          ApplyForAdmissionCounselling(),
          SizedBox(height: 24),
          TopUniversities(),
          SizedBox(height: 24),
          Testimonials(),
          SizedBox(height: 24),
          ConnectNow(),
          TrustedBy(),
        ],
      ),
    );
  }
}
