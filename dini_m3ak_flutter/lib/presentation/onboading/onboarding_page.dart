import 'package:dini_maak/presentation/auth/login/login_page.dart';
import 'package:dini_maak/presentation/onboading/provider/OnboadingProvider.dart';
import 'package:dini_maak/shared/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnBoardingPage extends StatefulWidget {
  static String homePage = "/home";

  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: OnboardingProvider.pages.length,
                  itemBuilder: (_, pageIndex) =>
                      OnboardingProvider.pages[pageIndex],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    OnboardingProvider.pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 2,
                      ),
                      width: currentPage == index ? 15 : 8,
                      height: currentPage == index ? 15 : 8,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? Colors.blue
                            : Colors.grey.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 10,
                      blurRadius: 10,
                      offset: const Offset(2, 3),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: MyButton(
                        isLoading: false,
                        color: Colors.blue.shade700,
                        text: "Login",
                        textColor: Colors.white,
                        onClick: () {
                          Navigator.pushNamed(context, LoginPage.logininPage);
                        },
                      ),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: MyButton(
                        isLoading: false,
                        color: Colors.black,
                        text: "Sign up",
                        textColor: Colors.white,
                        onClick: () {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
