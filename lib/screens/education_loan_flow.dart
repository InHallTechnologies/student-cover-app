import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/widgets/connect_now.dart';
import 'package:student_cover/widgets/education_loan_hero_card.dart';
import 'package:student_cover/widgets/screen_app_bar.dart';
import 'package:student_cover/widgets/study_destinations.dart';
import 'package:student_cover/widgets/testimonials.dart';
import 'package:student_cover/widgets/top_universities.dart';
import 'package:student_cover/widgets/trusted_by.dart';

class EducationLoanFlow extends StatefulWidget {
  static final String screenName = 'EducationLoanFlow';
  const EducationLoanFlow({super.key});

  @override
  State<EducationLoanFlow> createState() => _EducationLoanFlowState();
}

class _EducationLoanFlowState extends State<EducationLoanFlow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getScreenAppBar("Education Loan"),
      body: ListView(
        children: [
          EducationLoanHeroCard(),
          SizedBox(height: 24),
          Testimonials(),
          SizedBox(height: 24),
          TopUniversities(),
          SizedBox(height: 24),
          ConnectNow(),
          SizedBox(height: 24),
          TrustedBy(),
        ],
      ),
    );
  }
}
