import 'dart:ui';

import 'package:flutter/material.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final carouselWidth = screenWidth - (2 * 16) - 12;

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 5,
        padEnds: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double page = _pageController.page ?? 0;
              double distance = (index - page).clamp(-1.0, 1.0);
              double blur = distance.abs() * 3;

              return ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: blur),
                child: Container(
                  width: carouselWidth,
                  margin: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    fit: BoxFit.cover,
                    "https://picsum.photos/800/${512 + index}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
