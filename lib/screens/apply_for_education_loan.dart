import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/widgets/apply_for_education_loan_sections/destination_details.dart';
import 'package:student_cover/widgets/apply_for_education_loan_sections/loan_details.dart';
import 'package:student_cover/widgets/apply_for_education_loan_sections/personal_details.dart';
import 'package:student_cover/widgets/input_field.dart';
import 'package:student_cover/widgets/screen_app_bar.dart';

class ApplyForEducationLoan extends StatefulWidget {
  static final String screenName = "ApplyForEducationLoanScreen";
  const ApplyForEducationLoan({super.key});

  @override
  State<ApplyForEducationLoan> createState() => _ApplyForEducationLoanState();
}

class _ApplyForEducationLoanState extends State<ApplyForEducationLoan> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animation = Tween<double>(begin: 0, end: 0).animate(_animationController);
  }

  void updateSection(int newIndex) {
    _animation = Tween<double>(
      begin: currentIndex.toDouble(),
      end: newIndex.toDouble(),
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));
    _animationController.forward(from: 0);
    setState(() {
      currentIndex = newIndex;
    });
  }

  Offset getOffset(double screenSize, double index) {
    return Offset(lerpDouble(0, screenSize, index) ?? 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kPrimaryDark,
      body: Stack(
        children: [
          Positioned(
            bottom: -60,
            right: -80,
            child: Hero(
              tag: "education_loan_apply_now_sc_logo",
              child: Opacity(opacity: 0.2, child: Image.asset("images/student_cover_logo_only_white.png", width: 200)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ApplyEducationLoanTitle(),
              FormProgressIndicator(progress: currentIndex / 3, currentIndex: currentIndex),
              Container(
                margin: EdgeInsets.all(16),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, widget) {
                    return Stack(
                      children: [
                        Transform.translate(
                          offset: getOffset(screenWidth, 0.0 - _animation.value),
                          child: PersonalDetails(updateSection: updateSection),
                        ),
                        Transform.translate(
                          offset: getOffset(screenWidth, 1.0 - _animation.value),
                          child: DestinationDetails(updateSection: updateSection),
                        ),
                        Transform.translate(
                          offset: getOffset(screenWidth, 2 - _animation.value),
                          child: LoanDetails(updateSection: updateSection),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FormProgressIndicator extends StatefulWidget {
  double progress;
  int currentIndex;
  FormProgressIndicator({super.key, required this.progress, this.currentIndex = 0});

  @override
  State<FormProgressIndicator> createState() => _FormProgressIndicatorState();
}

class _FormProgressIndicatorState extends State<FormProgressIndicator> {
  final List<String> stepName = ["Personal Details", "Destination Details", "Loan Details"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(stepName[widget.currentIndex], style: hSubheadlineStyle, key: Key(stepName[widget.currentIndex])),
              Text("Step ${widget.currentIndex + 1} of 3", style: hSubheadlineStyle.copyWith(fontSize: 13, color: Colors.white60)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              tween: Tween<double>(begin: 0, end: widget.progress),
              builder: (context, value, _) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 6,
                  semanticsLabel: 'Linear progress indicator',
                  backgroundColor: Colors.white24,
                  color: accent,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ApplyEducationLoanTitle extends StatelessWidget {
  const ApplyEducationLoanTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 52, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Start Your Journey", style: kHeadlineStyle.copyWith(fontSize: 26, letterSpacing: 0.3)),
              Text("In Just 3 Simple Steps", style: hSubheadlineStyle.copyWith(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}
