import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/color_pallete.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/modules/login/pages/login_view.dart';
import 'package:movies_app/modules/onborarding/models/onboarding_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const String routeName = '/onboarding';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: OnBoardingData.onBoardingList.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final item = OnBoardingData.onBoardingList[index];
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(item.imagePath, fit: BoxFit.cover),
              ),
              Column(
                children: [
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: index == 0
                          ? Colors.transparent
                          : ColorPallete.backgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          item.title,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: ColorPallete.textWhiteColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item.description,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: ColorPallete.textWhiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (index == 0) ...[
                              CustomButton(
                                onTap: () => _goNext(),
                                child: Text(
                                  "Explore Now",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: ColorPallete.textBlackColor,
                                  ),
                                ),
                              ),
                            ] else ...[
                              CustomButton(
                                onTap: () {
                                  if (index ==
                                      OnBoardingData.onBoardingList.length -
                                          1) {
                                    _seenOnBoarding();
                                  } else {
                                    _goNext();
                                  }
                                },
                                child: Text(
                                  index ==
                                          OnBoardingData.onBoardingList.length -
                                              1
                                      ? "Finish"
                                      : "Next",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: ColorPallete.textBlackColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              if (index > 1)
                                CustomButton(
                                  onTap: () => _goBack(),
                                  child: Text(
                                    "Back",
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: ColorPallete.primaryColor,
                                    ),
                                  ),
                                  backgroundColor: Colors.transparent,
                                  borderColor: ColorPallete.primaryColor,
                                ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _goNext() {
    pageController.animateToPage(
      currentIndex + 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _goBack() {
    pageController.animateToPage(
      currentIndex - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _seenOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("firstTime", false);
    Navigator.pushReplacementNamed(context, LoginView.routeName);
  }
}
