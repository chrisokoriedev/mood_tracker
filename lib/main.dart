import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double windowWidth = constraints.maxWidth;
        final double windowHeight = constraints.maxHeight;

        final bool isLargeWeb = kIsWeb && windowWidth > 400;
        final double layoutWidth = isLargeWeb ? 400 : windowWidth;

        final baseMediaQuery = MediaQueryData.fromView(View.of(context));
        final modifiedMediaQuery = baseMediaQuery.copyWith(
          size: Size(layoutWidth, windowHeight),
        );

        Widget appTree = MediaQuery(
          data: modifiedMediaQuery,
          child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                builder: (context, appChild) {
                  final mediaQuery = MediaQuery.of(context);
                  // Maintain your text scaling clamping limits
                  Widget builtChild = MediaQuery(
                    data: mediaQuery.copyWith(
                      textScaler: mediaQuery.textScaler.clamp(
                        minScaleFactor: 1,
                        maxScaleFactor: 1.05,
                      ),
                    ),
                    child: appChild ?? const SizedBox.shrink(),
                  );

                  if (isLargeWeb) {
                    builtChild = Scaffold(
                      backgroundColor: const Color(0xFF1E1E1E),
                      body: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.spMin),
                            child: builtChild,
                          ),
                        ),
                      ),
                    );
                  }

                  return builtChild;
                },
                home: const HomePage(),
              );
            },
          ),
        );

        return appTree;
      },
    );
  }
}
