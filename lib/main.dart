import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maps_test/screens/home/home_screen.dart';
import 'package:maps_test/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'l10n/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  final locale = prefs.getString('language');

  runApp(
    ProviderScope(
      child: MyApp(showHome: showHome, locale: locale),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool showHome;
  final String? locale;

  const MyApp({super.key, required this.showHome, required this.locale});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: locale == null ? null : Locale(locale!),
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // useMaterial3: true,
      ),
      home: showHome ? const HomeScreen() : const OnboardingScreen(),
    );
  }
}

class StorageManager {}
