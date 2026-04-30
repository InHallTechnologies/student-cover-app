import 'package:flutter/material.dart';
import 'package:student_cover/widgets/screen_app_bar.dart';

class HealthInsuranceFlow extends StatefulWidget {
  static final String screenName = "HealthInsuranceFlow";
  const HealthInsuranceFlow({super.key});

  @override
  State<HealthInsuranceFlow> createState() => _HealthInsuranceFlowState();
}

class _HealthInsuranceFlowState extends State<HealthInsuranceFlow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, appBar: getScreenAppBar("Health Insurance"));
  }
}
