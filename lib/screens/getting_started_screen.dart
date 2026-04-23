import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/screens/authentication_screen.dart';
import 'package:student_cover/screens/home_screen.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({super.key});
  static final String screenName = "GettingStarted";

  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  late final PageController _pageController;
  late final double screenWidth = MediaQuery.of(context).size.width;
  int activeIndex = 0;

  List<Map<String, dynamic>> pages = [
    {
      "image": "images/getting_started.jpg",
      "title": "Education Loan",
      "description":
          "Lowest ROI guaranteed with fast approval from Indian & international lenders.",
    },
    {
      "image": "images/getting_started_1.jpg",
      "title": "Student Health Insurance",
      "description":
          "Affordable plans from Indian & global insurers with claim and waiver assistance.",
    },
    {
      "image": "images/getting_started_2.jpg",
      "title": "Admission Counselling",
      "description":
          "Get guidance for top universities with no-cost counselling and application fee waivers.",
    },
    {
      "image": "images/getting_started.jpg",
      "title": "Travel Insurance",
      "description":
          "Comprehensive travel coverage including baggage and parents travel insurance.",
    },
    {
      "image": "images/getting_started_1.jpg",
      "title": "Loan Partners",
      "description":
          "Access multiple lenders like ICICI, Axis, Tata Capital, and more in one place.",
    },
    {
      "image": "images/getting_started_2.jpg",
      "title": "All-in-One Services",
      "description": "A complete marketplace for study abroad services.",
    },
    {
      "image": "images/getting_started.jpg",
      "title": "Affordable Plans",
      "description":
          "Insurance plans at up to 1/3rd the cost of university-provided options.",
    },
    {
      "image": "images/getting_started_1.jpg",
      "title": "Trusted Experience",
      "description":
          "12+ years of mentoring students with thousands of successful cases.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: pages.length,
            controller: _pageController,
            onPageChanged: (newIndex) {
              setState(() {
                activeIndex = newIndex;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  num distance = (index - (_pageController.page ?? 0)).clamp(
                    -1.0,
                    1.0,
                  );

                  double blur = distance.abs() * 10;
                  return ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                    child: CarouselItem(page: pages[index]),
                  );
                },
              );
            },
          ),
          BottomInformation(
            title: pages[activeIndex]['title'],
            subTitle: pages[activeIndex]['description'],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Hero(
              tag: "sc_logo",
              child: Image.asset(
                "images/student_cover_logo.png",
                width: 80,
                height: 80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomInformation extends StatefulWidget {
  final String title;
  final String subTitle;
  const BottomInformation({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  State<BottomInformation> createState() => _BottomInformationState();
}

class _BottomInformationState extends State<BottomInformation> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(20),
        height: 200,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Column(
                key: ValueKey<String>(widget.title),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(widget.title, style: kHeadlineStyle),
                  Text(widget.subTitle, style: hSubheadlineStyle),
                  SizedBox(height: 20),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AuthenticationScreen.screenName);
              },
              style: kPrimaryButtonStyle,
              child: Text("Get Started", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselItem extends StatelessWidget {
  const CarouselItem({super.key, required this.page});

  final Map<String, dynamic> page;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          ShaderMask(
            child: Image.asset(
              page['image'],
              fit: BoxFit.cover,
              height: double.infinity,
            ),
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[
                  Colors.black,
                  Colors.black,
                  Colors.white,
                  Colors.white,
                ],
              ).createShader(bounds);
            },
          ),
        ],
      ),
    );
  }
}
