import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/widgets/app_bar.dart';
import 'package:student_cover/widgets/banner_carousel.dart';
import 'package:student_cover/widgets/quick_tools.dart';
import 'package:student_cover/widgets/service_selector.dart';
import 'package:student_cover/widgets/status_and_reminders.dart';

class HomeScreen extends StatefulWidget {
  static final String screenName = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: MyAppBar(),
      bottomNavigationBar: BottomNavigation(),
      floatingActionButton: Container(
        child: FloatingActionButton(
          backgroundColor: kPrimaryDark,
          elevation: 0, // Using custom shadow for premium look
          shape: const CircleBorder(),
          onPressed: () {},
          child: Image.asset("images/chat_icon_round.png"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            BannerCarousel(),
            SizedBox(height: 10),
            ServiceSelector(),
            SizedBox(height: 10),
            QuickTools(),
            SizedBox(height: 10),
            StatusAndReminders(),
          ],
        ),
      ),
    );
  }

  Widget BottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        notchMargin: 10.0,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SafeArea(
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: selectedIndex,
            backgroundColor: Colors.transparent,
            onTap: (newIndex) {
              setState(() {
                selectedIndex = newIndex;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: accent, // Vibrant blue
            unselectedItemColor: kGreyColor,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.description_outlined), activeIcon: Icon(Icons.description_rounded), label: "Applications"),
              BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded), activeIcon: Icon(Icons.chat_bubble_rounded), label: "Support"),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), activeIcon: Icon(Icons.person_rounded), label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
