import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_cover/firebase_options.dart';
import 'package:student_cover/screens/apply_for_education_loan.dart';
import 'package:student_cover/screens/apply_for_insurance.dart';
import 'package:student_cover/screens/authentication_screen.dart';
import 'package:student_cover/screens/create_account.dart';
import 'package:student_cover/screens/education_loan_flow.dart';
import 'package:student_cover/screens/getting_started_screen.dart';
import 'package:student_cover/screens/health_insurance_flow.dart';
import 'package:student_cover/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const StudentCover());
}

class StudentCover extends StatelessWidget {
  const StudentCover({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.screenName,
      debugShowCheckedModeBanner: false,
      routes: {
        GettingStarted.screenName: (context) => const GettingStarted(),
        AuthenticationScreen.screenName: (context) => const AuthenticationScreen(),
        HomeScreen.screenName: (context) => const HomeScreen(),
        CreateAccount.screenName: (context) => const CreateAccount(),
        EducationLoanFlow.screenName: (context) => const EducationLoanFlow(),
        ApplyForEducationLoan.screenName: (context) => const ApplyForEducationLoan(),
        HealthInsuranceFlow.screenName: (context) => const HealthInsuranceFlow(),
        CompareAndApplyInsurance.screenName: (context) => const CompareAndApplyInsurance(),
      },
    );
  }
}
