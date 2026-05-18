# Mood Track - Project Overview 🙂

A Flutter web mood journaling app where users can log how they feel, review their latest mood history, and interact with animated timeline cards. Mood Tracker is a single-screen Flutter web experience focused on speed and simplicity, where users can pick a mood, save entries locally, and view the most recent entries in a horizontal timeline.

## Live App

- Production URL: https://mood-tracker-nine-kappa.vercel.app

## Loom Walkthrough

- Demo URL (replace with your final video): https://www.loom.com/share/8177fe287cb440f596f8bdda25737966

## Highlights

| Features | Tech Stack | Project Structure |
|---|---|---|
| - Log moods from selector<br>- Persist entries with Hive<br>- Show last 7 in horizontal timeline<br>- Tap cards for short animation<br>- Responsive centered web layout | - Flutter Web<br>- Riverpod<br>- Hive<br>- intl<br>- flutter_screenutil | - lib/main.dart (boot, Hive init)<br>- lib/features/home.dart (screen)<br>- lib/core/models (data types)<br>- lib/core/providers (state)<br>- lib/util/widgets (UI pieces)<br>- lib/util/painters (face drawing) |

## Quick Ops

| Run Locally | Build for Web | Deployment | Submission Checklist |
|---|---|---|---|
| `flutter pub get`<br>`flutter run -d chrome` | `flutter build web --release` | Configured for Vercel using vercel.json<br>Output: build/web | - Live app URL added<br>- Loom URL added<br>- Public repo ready<br>- Desktop/mobile web tested |
