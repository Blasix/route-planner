import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'home/home_screen.dart';

final _isLastPage = StateProvider((ref) => false);

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLastPage = ref.watch(_isLastPage);
    final controller = usePageController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          // TODO: add real onboarding content
          controller: controller,
          onPageChanged: (value) =>
              ref.read(_isLastPage.notifier).state = value == 2,
          children: <Widget>[
            Container(
              color: Colors.red,
              child: const Center(
                child: Text('Page 1'),
              ),
            ),
            Container(
              color: Colors.blue,
              child: const Center(
                child: Text('Page 2'),
              ),
            ),
            Container(
              color: Colors.green,
              child: const Center(
                child: Text('Page 3'),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size.fromHeight(80)),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);

                ref.read(_isLastPage.notifier).state = false;

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 24),
              ))
          : SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () => controller.animateToPage(
                      2,
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 500),
                    ),
                    child: const Text('SKIP'),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                        spacing: 16,
                        activeDotColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.nextPage(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 500),
                    ),
                    child: const Text('NEXT'),
                  ),
                ],
              ),
            ),
    );
  }
}
