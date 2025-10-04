import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/config/routes/router.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const _pages = [
    OnboardingPage(title: 'Welcome', description: 'Welcome to our app!'),
    OnboardingPage(title: 'Discover', description: 'Discover great features.'),
    OnboardingPage(title: 'Enjoy', description: 'Enjoy using our app.'),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OnboardingController>();

    final isLast = controller.currentPage == _pages.length - 1;

    return Scaffold(
      body: PageView.builder(
        controller: controller.pageController,
        itemCount: _pages.length,
        onPageChanged: controller.onPageChanged,
        itemBuilder: (_, index) => _pages[index],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              TextButton(
                onPressed: () async {
                  await controller.markCompleted();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRouter.signIn,
                    ); //later will be changed to login because and there the data will check if the user is logged in navigate to homescreen else navigate to login screen but for now we are testing.
                  }
                },
                child: const Text('Skip'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (isLast) {
                    await controller.markCompleted();
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRouter.signIn,
                      ); //same as above testing purpose.
                    }
                  } else {
                    controller.onNextPage();
                  }
                },
                child: Text(isLast ? 'Done' : 'Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
