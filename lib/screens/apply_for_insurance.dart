import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/screens/plan_list.dart';
import 'package:student_cover/services/AlertManager.dart';
import 'package:student_cover/widgets/auto_complete_input_field.dart';
import 'package:student_cover/widgets/input_field.dart';
import 'package:student_cover/widgets/screen_app_bar.dart';
import 'package:http/http.dart' as http;

class CompareAndApplyInsurance extends StatefulWidget {
  static final String screenName = "ApplyForInsuranceScreen";
  const CompareAndApplyInsurance({super.key});

  @override
  State<CompareAndApplyInsurance> createState() => _CompareAndApplyInsuranceState();
}

class _CompareAndApplyInsuranceState extends State<CompareAndApplyInsurance> {
  String _selectedCountry = "";
  String _selectedUniversity = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: getScreenAppBar("Compare and Apply"),
      body: Stack(
        children: [
          Positioned(
            right: -90,
            bottom: -90,
            child: Hero(
              tag: "health_insurance_apply_now_sc_logo",
              child: Opacity(opacity: 0.2, child: Image.asset("images/student_cover_logo_only.png", height: 400)),
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: kCtaBoxDecoration.copyWith(color: kPrimaryDark),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
                      child: const Icon(Icons.school, color: Colors.white, size: 28),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Find Your Perfect Plan", style: kCtaHeadlineStyle),
                          const SizedBox(height: 4),
                          Text("Compare plans tailored to your destination", style: kCtaSubheadlineStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.all(16).copyWith(top: 0),
                padding: const EdgeInsets.all(24),
                decoration: kDefaultCardDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AutoCompleteInputField(
                      title: "Study Destination",
                      onChange: (text) {
                        setState(() {
                          _selectedCountry = text;
                        });
                      },
                      optionsGenerator: (newText) async {
                        final uri = Uri.parse("https://us-central1-student-cover.cloudfunctions.net/get_country_list_shallow");
                        final response = await http.get(uri);
                        final items = jsonDecode(response.body) as List;
                        return items.map((e) => e.toString()).toList();
                      },
                    ),
                    const SizedBox(height: 20),
                    AutoCompleteInputField(
                      title: "Desired University",
                      onChange: (text) {
                        setState(() {
                          _selectedUniversity = text;
                        });
                      },
                      optionsGenerator: (newText) async {
                        final uri = Uri.parse("https://get-university-of-country-nsjtdy3gnq-uc.a.run.app/?country=$_selectedCountry");
                        final response = await http.get(uri);
                        final items = jsonDecode(response.body) as List;
                        return items.map((e) => e.toString()).toList();
                      },
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: () {
                        if (_selectedCountry.isEmpty) {
                          AlertManager(context: context).showAlertDialog("Please select your destination country");
                          return;
                        }

                        if (_selectedUniversity.isEmpty) {
                          AlertManager(context: context).showAlertDialog("Please select your desired university in $_selectedCountry");
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlanList(country: _selectedCountry, university: _selectedUniversity),
                          ),
                        );
                      },
                      style: kAccentButtonStyle.copyWith(
                        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
                        textStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                      child: Text("Find Plans"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
