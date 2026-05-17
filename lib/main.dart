import 'package:flutter/material.dart';
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
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (_, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      },
    );
  }
}
