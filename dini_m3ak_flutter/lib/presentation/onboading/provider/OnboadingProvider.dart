import 'package:dini_maak/presentation/onboading/page_one.dart';
import 'package:flutter/material.dart';

class OnboardingProvider {
  static List<Widget> pages = const [
    PageOne(
      image: "assets/1.png",
      subTitle:
          "Join the carpooling community and save time and money on your daily commute",
      title: "Reduce Cost",
    ),
    PageOne(
      image: "assets/2.png",
      subTitle:
          "Reduce your carbon footprint and help to reduce traffic congestion",
      title: "Save Environment",
    ),
    PageOne(
      image: "assets/3.png",
      subTitle:
          "Enjoy a stress-free commute with real-time carpool tracking and notifications",
      title: "Stress Free Commute",
    ),
  ];
}
