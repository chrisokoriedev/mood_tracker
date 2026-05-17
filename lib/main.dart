import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_tracker/core/contants/app_colors.dart';
import 'package:mood_tracker/core/contants/app_strings.dart';
import 'package:mood_tracker/core/models/mood_entry.dart';
import 'package:mood_tracker/core/models/mood_type.dart';
import 'package:mood_tracker/features/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MoodEntryAdapter());
  Hive.registerAdapter(MoodTypeAdapter());
  await Hive.openBox<MoodEntry>(AppStrings.hiveBox);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
      ),
      home: Builder(
        builder: (context) {
          final isWebOrDesktop = MediaQuery.of(context).size.width > 600;

          if (!isWebOrDesktop) {
            return const ScreenUtilWrapper(child: HomePage());
          }

          // Desktop/Web View - Render inside a premium centered mobile frame mockup
          return Scaffold(
            backgroundColor: const Color(0xFF0F172A), // Slate-900 premium dark background
            body: Center(
              child: Container(
                width: 375,
                height: 812,
                margin: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.55),
                      blurRadius: 40,
                      offset: const Offset(0, 20),
                    ),
                  ],
                  border: Border.all(
                    color: const Color(0xFF334155), // Slate-700 phone border
                    width: 8,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: const MediaQuery(
                    data: MediaQueryData(
                      size: Size(375, 812),
                      padding: EdgeInsets.only(top: 44, bottom: 34), // Mock phone safe areas
                      devicePixelRatio: 2.0,
                    ),
                    child: ScreenUtilWrapper(child: HomePage()),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ScreenUtilWrapper extends StatelessWidget {
  final Widget child;
  const ScreenUtilWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (_, _) => child,
    );
  }
}
