# Mood Tracker — Flutter Web App
## Project Documentation

**Task Deadline:** May 8, 2026 — 3:00 PM CST  
**Platform:** Flutter Web  
**Deployment Targets:** Firebase Hosting or Vercel

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Feature Requirements](#2-feature-requirements)
3. [Tech Stack & Packages](#3-tech-stack--packages)
4. [Package Research & Justification](#4-package-research--justification)
5. [Project Architecture](#5-project-architecture)
6. [Folder Structure](#6-folder-structure)
7. [CustomPainter Face Design Guide](#7-custompainter-face-design-guide)
8. [State Management Approach](#8-state-management-approach)
9. [Data Model](#9-data-model)
10. [UI Component Breakdown](#10-ui-component-breakdown)
11. [Animation Plan](#11-animation-plan)
12. [Deployment Guide](#12-deployment-guide)
13. [Git Commit Strategy](#13-git-commit-strategy)
14. [Loom Walkthrough Script](#14-loom-walkthrough-script)
15. [Future Improvements](#15-future-improvements)

---

## 1. Project Overview

A single-screen Flutter web application that allows users to log their current mood, view their last 7 entries in a horizontal scrollable timeline, and tap any past entry to trigger a brief animation. Mood faces are drawn entirely using Flutter's `CustomPainter` class — no emoji, icon fonts, or images.

---

## 2. Feature Requirements

| # | Requirement | Details |
|---|-------------|---------|
| 1 | Mood logging | User taps a mood face to log how they feel |
| 2 | Past 7 entries | Horizontal scrollable timeline showing the last 7 logs |
| 3 | Entry tap animation | Tapping a past entry triggers a brief visual animation |
| 4 | CustomPainter faces | At least 3 distinct expressions using `drawCircle`, `drawArc`, `drawPath` |
| 5 | Timeline card content | Each card shows: date, drawn face, color accent matching mood |
| 6 | Deployed live URL | Firebase Hosting or Vercel |
| 7 | Public GitHub repo | With natural commit history |
| 8 | Loom video | Under 5 minutes, covers state management, CustomPainter, and one improvement |

---

## 3. Tech Stack & Packages

### Core

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter` | SDK | Core framework |
| `flutter_riverpod` | ^3.0.0 | State management |
| `riverpod_annotation` | ^3.0.0 | Code generation annotations |
| `hive_flutter` | ^1.1.0 | Local persistence (mood log storage) |
| `hive` | ^2.2.3 | NoSQL box storage |
| `intl` | ^0.19.0 | Date formatting for timeline cards |

### Dev Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `riverpod_generator` | ^3.0.0 | Generates providers from annotations |
| `build_runner` | ^2.4.9 | Code generation runner |
| `hive_generator` | ^2.0.1 | Generates Hive type adapters |
| `riverpod_lint` | ^3.0.0 | Riverpod-specific lint rules |
| `custom_lint` | ^0.7.0 | Required by riverpod_lint |
| `flutter_lints` | ^4.0.0 | General lint rules |

### pubspec.yaml (complete dependencies block)

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^3.0.0
  riverpod_annotation: ^3.0.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  intl: ^0.19.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  riverpod_generator: ^3.0.0
  build_runner: ^2.4.9
  hive_generator: ^2.0.1
  riverpod_lint: ^3.0.0
  custom_lint: ^0.7.0
  flutter_lints: ^4.0.0
```

---

## 4. Package Research & Justification

### State Management: `flutter_riverpod` + `riverpod_annotation`

**Why Riverpod over BLoC or Provider?**

- This is a single-screen app with a list of mood entries and a selected/animated entry. Riverpod's `Notifier` + `StateNotifier` handles this cleanly without streams or event boilerplate.
- Riverpod 2.x with code generation (`@riverpod`) removes the need for manual `Provider` declarations and gives compile-time safety.
- The `ref.watch` / `ref.read` pattern integrates naturally with `ConsumerWidget` — no `BuildContext` threading needed across widgets.
- BLoC would be overkill for this scope. Provider would work, but Riverpod is cleaner for testability and Dart 3 patterns.

**What it manages:**
- `List<MoodEntry>` — all stored mood logs
- `String? animatingEntryId` — tracks which timeline card is currently animating

### Local Storage: `hive_flutter`

**Why Hive over `shared_preferences` or `sqflite`?**

- `shared_preferences` only handles key-value primitives (String, int, bool). Storing a list of typed `MoodEntry` objects requires manual JSON serialization per entry — error-prone.
- `sqflite` is relational and requires SQL schema setup. Overkill for a simple ordered list of structs.
- Hive stores typed Dart objects natively using generated `TypeAdapter`s. It also works on Flutter Web using **IndexedDB** under the hood — critical for this web deployment.
- Hive's `Box.listenable()` can be used as a reactive data source compatible with Riverpod.
- Performance: Hive reads/writes are significantly faster than `shared_preferences` for object data (~500ms vs ~8000ms for 1000 ops).

**Web compatibility note:** `hive_flutter` handles web storage automatically. No extra config is needed beyond `Hive.initFlutter()`.

### Date Formatting: `intl`

- Used to format `DateTime` to human-readable strings like `"Mon, 12 May"` on each timeline card.
- `DateFormat('EEE, d MMM').format(entry.timestamp)` gives clean, locale-aware output.
- No alternative needed — this is the standard Dart internationalization package.

---

## 5. Project Architecture

The project uses a **flat feature-first structure** since it is a single-screen app. Layers follow a simplified clean architecture pattern:

```
UI (Widgets)
    ↓ watches
Riverpod Providers (Notifiers)
    ↓ read/write
Repository (MoodRepository)
    ↓ calls
Hive Storage (Local Box)
```

**Rules:**
- Widgets never call Hive directly — always go through a provider.
- The repository is the only class that touches Hive boxes.
- Providers hold and expose state — they do not hold `BuildContext`.
- All providers live in dedicated `providers/` files, never declared inside widgets.

---

## 6. Folder Structure

```
mood_tracker/
├── lib/
│   ├── main.dart                        # App entry, Hive init, ProviderScope
│   ├── app.dart                         # MaterialApp config, theme
│   │
│   ├── models/
│   │   ├── mood_entry.dart              # MoodEntry data class
│   │   ├── mood_entry.g.dart            # Generated Hive TypeAdapter
│   │   └── mood_type.dart               # MoodType enum (happy, neutral, sad, excited, anxious)
│   │
│   ├── repositories/
│   │   └── mood_repository.dart         # Hive read/write wrapper
│   │
│   ├── providers/
│   │   ├── mood_provider.dart           # MoodNotifier (StateNotifier for mood list)
│   │   ├── mood_provider.g.dart         # Generated Riverpod code
│   │   └── animation_provider.dart      # Tracks which card is animating
│   │
│   ├── painters/
│   │   ├── face_painter.dart            # Dispatches to correct face based on MoodType
│   │   ├── happy_face_painter.dart      # CustomPainter: upward arc mouth, raised brows
│   │   ├── neutral_face_painter.dart    # CustomPainter: flat line mouth, level brows
│   │   ├── sad_face_painter.dart        # CustomPainter: downward arc mouth, angled brows
│   │   ├── excited_face_painter.dart    # CustomPainter: wide arc, star-shaped eyes
│   │   └── anxious_face_painter.dart    # CustomPainter: wavy mouth, furrowed brows
│   │
│   ├── screens/
│   │   └── home_screen.dart             # Single screen: mood selector + timeline
│   │
│   └── widgets/
│       ├── mood_selector.dart           # Row of tappable mood faces (top section)
│       ├── mood_face_widget.dart        # Renders a single CustomPaint face
│       ├── timeline_section.dart        # Horizontal ListView of timeline cards
│       └── timeline_card.dart           # Individual card: date + face + color accent
│
├── test/
│   └── mood_provider_test.dart
│
├── web/
│   └── index.html                       # Flutter web entry
│
└── pubspec.yaml
```

---

## 7. CustomPainter Face Design Guide

Each face is a `CustomPainter` subclass drawn on a square canvas. The drawing uses a coordinate system relative to the canvas `size`.

### Canvas Coordinate Convention

```
size.width  = full width of the CustomPaint widget
size.height = full height (assumed square, e.g. 80x80)

Center:        Offset(size.width / 2, size.height / 2)
Face circle:   radius = size.width * 0.45
Left eye:      Offset(size.width * 0.35, size.height * 0.38)
Right eye:     Offset(size.width * 0.65, size.height * 0.38)
Eye radius:    size.width * 0.07
Mouth rect:    Rect from (0.25w, 0.52h) to (0.75w, 0.80h)
```

### Face Variants

#### Happy Face
```
Head:      drawCircle — yellow fill, dark stroke
Eyes:      drawCircle — two filled circles
Mouth:     drawArc — upward sweep (startAngle: 0, sweepAngle: π, clockwise: true)
Brows:     drawLine — slight upward angle (relaxed)

Key arc params: sweepAngle = pi (180°), useCenter: false, style: stroke
```

#### Neutral Face
```
Head:      drawCircle — grey-blue fill
Eyes:      drawCircle — standard circles
Mouth:     drawLine — straight horizontal line at 65% height
Brows:     drawLine — perfectly horizontal, no angle

Key: mouth is a simple lineTo path, not an arc
```

#### Sad Face
```
Head:      drawCircle — muted blue fill
Eyes:      drawCircle — standard circles
Mouth:     drawArc — downward sweep (startAngle: pi, sweepAngle: pi, clockwise: true)
Brows:     drawLine — angled downward toward center (furrowed)

Key: brow angle is the clearest visual differentiator from happy
```

#### Excited Face
```
Head:      drawCircle — bright orange/yellow fill
Eyes:      drawPath — star or sparkle shapes (using moveTo / lineTo)
Mouth:     drawArc — wide arc, larger than happy (80% width)
Brows:     drawLine — arched upward, away from center

Key: eyes use Path with multiple lineTo to create star points
```

#### Anxious Face
```
Head:      drawCircle — pale green fill
Eyes:      drawCircle — slightly larger (wide-eyed look)
Mouth:     drawPath — wavy line using quadraticBezierTo (2 humps)
Brows:     drawLine — steep inward angle, close to eyes

Key: mouth uses quadraticBezierTo for the wavy effect
```

### Sample CustomPainter — Happy Face

```dart
class HappyFacePainter extends CustomPainter {
  final Color faceColor;
  final Color strokeColor;

  HappyFacePainter({
    this.faceColor = const Color(0xFFFFD700),
    this.strokeColor = const Color(0xFF333333),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = faceColor
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.45;

    // Face circle
    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(center, radius, strokePaint);

    // Eyes
    final eyePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.35, size.height * 0.38),
      size.width * 0.07,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.65, size.height * 0.38),
      size.width * 0.07,
      eyePaint,
    );

    // Smile arc (upward)
    final mouthRect = Rect.fromLTRB(
      size.width * 0.25,
      size.height * 0.50,
      size.width * 0.75,
      size.height * 0.82,
    );
    canvas.drawArc(mouthRect, 0, pi, false, strokePaint);

    // Eyebrows (relaxed, slight upward angle)
    canvas.drawLine(
      Offset(size.width * 0.27, size.height * 0.26),
      Offset(size.width * 0.43, size.height * 0.23),
      strokePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.57, size.height * 0.23),
      Offset(size.width * 0.73, size.height * 0.26),
      strokePaint,
    );
  }

  @override
  bool shouldRepaint(HappyFacePainter oldDelegate) =>
      oldDelegate.faceColor != faceColor;
}
```

### Sample — Anxious Face (wavy mouth using quadraticBezierTo)

```dart
// Wavy mouth path
final mouthPath = Path()
  ..moveTo(size.width * 0.25, size.height * 0.65);

mouthPath.quadraticBezierTo(
  size.width * 0.375, size.height * 0.55, // control point (hump up)
  size.width * 0.50,  size.height * 0.65,
);
mouthPath.quadraticBezierTo(
  size.width * 0.625, size.height * 0.75, // control point (hump down)
  size.width * 0.75,  size.height * 0.65,
);

canvas.drawPath(mouthPath, strokePaint);
```

### Mood Color Accents

| Mood | Face Color | Accent Color | Accent Hex |
|------|-----------|--------------|------------|
| Happy | Gold `#FFD700` | Amber | `#FFC107` |
| Neutral | Grey-blue `#90A4AE` | Slate | `#607D8B` |
| Sad | Muted blue `#64B5F6` | Indigo | `#5C6BC0` |
| Excited | Orange `#FF7043` | Deep orange | `#E64A19` |
| Anxious | Pale green `#A5D6A7` | Teal | `#26A69A` |

---

## 8. State Management Approach

### Architecture Decision: Riverpod 3.x with `@riverpod` annotation

> **Riverpod 3 key changes used in this project:**
> - `AutoDisposeNotifier` and `Notifier` are now merged into a single unified `Notifier` class
> - `StateProvider` is now **legacy** — replaced with a dedicated `Notifier` subclass
> - `Ref` no longer carries generic parameters (was `Ref<T>`, now just `Ref`)
> - All providers use `==` equality (not `identical`) for rebuild filtering
> - Auto-retry is enabled by default for failing providers

The app has two pieces of global state:

**1. Mood entries list** — `MoodNotifier`  
Holds `List<MoodEntry>`, backed by Hive. On `build()`, loads last 7 entries from the box. On `addEntry(MoodType)`, creates a new entry, persists to Hive, and updates state.

```dart
// providers/mood_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mood_provider.g.dart';

@riverpod
class MoodNotifier extends _$MoodNotifier {
  @override
  List<MoodEntry> build() {
    final box = Hive.box<MoodEntry>('mood_entries');
    return box.values.toList().reversed.take(7).toList();
  }

  void addEntry(MoodType mood) {
    final entry = MoodEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      mood: mood,
      timestamp: DateTime.now(),
    );
    final box = Hive.box<MoodEntry>('mood_entries');
    box.add(entry);
    // Riverpod 3: == equality is used — a new List triggers rebuild correctly
    state = box.values.toList().reversed.take(7).toList();
  }
}
```

**2. Animating entry ID** — `AnimationNotifier`  
In Riverpod 3, `StateProvider` is legacy. Replace it with a lightweight `Notifier` subclass. This holds the ID of the currently animating card and resets to `null` automatically.

```dart
// providers/animation_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'animation_provider.g.dart';

@riverpod
class AnimationNotifier extends _$AnimationNotifier {
  @override
  String? build() => null; // no card animating by default

  void triggerAnimation(String entryId) {
    state = entryId;
    Future.delayed(const Duration(milliseconds: 600), () {
      // Riverpod 3: Ref.mounted check — safe to update after async gap
      if (ref.mounted) state = null;
    });
  }
}
```

> **Why `ref.mounted`?**  
> Riverpod 3 introduces `Ref.mounted` as a first-class safety check. Always guard async callbacks that write to state — if the provider was disposed before the delay completes, `ref.mounted` returns `false` and the write is safely skipped.

In `TimelineCard`:
```dart
onTap: () {
  ref.read(animationNotifierProvider.notifier).triggerAnimation(entry.id);
},
```

Watching animation state in `TimelineCard`:
```dart
// Riverpod 3: Ref has no generic params — just Ref, not Ref<Widget>
final animatingId = ref.watch(animationNotifierProvider);
final isAnimating = animatingId == entry.id;
```

### Why not BLoC?
BLoC's event→state cycle adds 3+ files per feature (event, state, bloc). For a two-state screen, it is structural overhead without architectural benefit. Riverpod 3's unified `Notifier` delivers the same separation of concerns in fewer lines, with Dart 3 patterns and compile-time safety.

### Why not setState?
The mood list must be shared between two widgets on the same screen (the timeline and the mood selector). `setState` would require lifting state up to `HomeScreen` and prop-drilling — Riverpod eliminates this via `ref.watch`.

---

## 9. Data Model

### `MoodType` Enum

```dart
enum MoodType { happy, neutral, sad, excited, anxious }
```

### `MoodEntry` (Hive Object)

```dart
import 'package:hive/hive.dart';

part 'mood_entry.g.dart';

@HiveType(typeId: 0)
class MoodEntry extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final MoodType mood;  // stored as int index

  @HiveField(2)
  final DateTime timestamp;

  MoodEntry({
    required this.id,
    required this.mood,
    required this.timestamp,
  });
}
```

**Generate the adapter:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Hive Initialization in `main.dart`

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MoodEntryAdapter());
  Hive.registerAdapter(MoodTypeAdapter()); // custom adapter for enum
  await Hive.openBox<MoodEntry>('mood_entries');
  runApp(const ProviderScope(child: MoodTrackerApp()));
}
```

---

## 10. UI Component Breakdown

### `HomeScreen`

Single `ConsumerWidget`. Layout:

```
Column
 ├── Header (app title + subtitle)
 ├── MoodSelector (how are you feeling?)
 │    └── Row of 5 tappable MoodFaceWidgets
 ├── Divider
 └── TimelineSection (your last 7 moods)
      └── SizedBox (height: 160)
           └── ListView.builder (scrollDirection: Axis.horizontal)
                └── TimelineCard (for each entry)
```

### `MoodFaceWidget`

```dart
GestureDetector(
  onTap: () => ref.read(moodNotifierProvider.notifier).addEntry(mood),
  child: CustomPaint(
    size: const Size(72, 72),
    painter: FacePainter(mood: mood),
  ),
)
```

### `TimelineCard`

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.elasticOut,
  transform: isAnimating
    ? Matrix4.rotationZ(0.05)  // brief wobble
    : Matrix4.identity(),
  decoration: BoxDecoration(
    color: Colors.white,
    border: Border.all(color: moodColor, width: 2),
    borderRadius: BorderRadius.circular(16),
  ),
  child: Column(
    children: [
      CustomPaint(painter: FacePainter(mood: entry.mood), size: Size(56, 56)),
      Text(formattedDate),
    ],
  ),
)
```

---

## 11. Animation Plan

**Type:** `AnimatedContainer` + `Matrix4` transform (scale + slight rotation)  
**Trigger:** `onTap` on a `TimelineCard`  
**Duration:** 600ms total — 300ms in, 300ms out  
**Mechanism:** `animatingEntryProvider` holds the tapped entry's ID. The `TimelineCard` watches this provider and applies a transform when its ID matches.

```dart
final isAnimating = ref.watch(animatingEntryProvider) == entry.id;

AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.elasticOut,
  transform: isAnimating
      ? (Matrix4.identity()
           ..scale(1.12)
           ..rotateZ(0.04))
      : Matrix4.identity(),
  transformAlignment: Alignment.center,
  child: ...,
)
```

This approach requires zero animation controllers — `AnimatedContainer` handles the tween automatically. After 600ms, the provider resets to `null` and the card eases back.

---

## 12. Deployment Guide

### Option A: Firebase Hosting

**Prerequisites:** `firebase-tools` installed globally, Firebase project created.

```bash
# 1. Install Firebase CLI (if not already)
npm install -g firebase-tools

# 2. Login
firebase login

# 3. Initialize (in project root)
firebase init hosting
# - Select your Firebase project
# - Set public directory to: build/web
# - Configure as SPA: Yes
# - Don't overwrite index.html

# 4. Build Flutter web
flutter build web --release

# 5. Deploy
firebase deploy --only hosting
```

The live URL will be: `https://YOUR_PROJECT_ID.web.app`

### Option B: Vercel

```bash
# 1. Install Vercel CLI
npm install -g vercel

# 2. Build Flutter web
flutter build web --release

# 3. Deploy from build/web directory
cd build/web
vercel --prod
```

**Vercel config (`vercel.json`):**
```json
{
  "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }]
}
```

### Web-Specific Flutter Config

In `web/index.html`, ensure the base href is set correctly:
```html
<base href="/">
```

In `pubspec.yaml`, confirm Flutter web renderer (use `canvaskit` for CustomPainter fidelity):
```yaml
flutter:
  web:
    renderer: canvaskit
```

---

## 13. Git Commit Strategy

A natural commit history should show iterative development, not a single dump. Suggested sequence:

```
feat: scaffold Flutter web project and configure pubspec.yaml
feat: add MoodType enum and MoodEntry Hive model
feat: generate Hive TypeAdapters and initialize storage in main.dart
feat: implement MoodRepository with add and getLast7 methods
feat: add MoodNotifier with Riverpod and wire to repository
feat: build HappyFacePainter using CustomPainter
feat: add NeutralFacePainter and SadFacePainter
feat: add ExcitedFacePainter and AnxiousFacePainter
feat: implement FacePainter dispatcher widget
feat: build MoodSelector widget with 5 tappable faces
feat: build TimelineCard with mood color accent and date
feat: build TimelineSection horizontal scrollable list
feat: wire animatingEntryProvider for tap animation
feat: implement AnimatedContainer wobble on timeline tap
feat: compose HomeScreen with header, selector, and timeline
feat: add app theme and responsive layout constraints
fix: correct Hive box initialization order on web
chore: flutter build web and configure firebase.json
deploy: push to Firebase Hosting
```

---

## 14. Loom Walkthrough Script

**Target: under 5 minutes**

**[0:00 – 0:30] Intro + Live Demo**
- Open the deployed URL.
- Log 3 different moods — show them appearing in the timeline.
- Tap a past entry to demonstrate the animation.

**[0:30 – 2:00] State Management Explanation**
- Open `providers/mood_provider.dart`.
- Explain: Riverpod `MoodNotifier` holds the mood list. `addEntry()` writes to Hive and updates state.
- Show `animatingEntryProvider` — a `StateProvider<String?>` that drives the card animation.
- Explain why Riverpod over BLoC: scope is a single screen, two state values, no event stream needed.

**[2:00 – 3:30] CustomPainter Faces**
- Open `painters/happy_face_painter.dart`.
- Walk through `paint()`: `drawCircle` for head and eyes, `drawArc` for the smile.
- Switch to `sad_face_painter.dart` — show how flipping the arc `startAngle` and changing brow angles creates a different expression.
- Show `anxious_face_painter.dart` — explain `quadraticBezierTo` for the wavy mouth.

**[3:30 – 4:30] One Thing I'd Improve**
> "With more time, I'd replace the raw `StateProvider` for animation with a proper `AnimationController` + `Tween` to give each face a bounce-in spring effect on initial log — right now the tap animation is a simple transform scale. I'd also add a weekly mood chart using `CustomPainter` arcs to visualize mood trends over time."

**[4:30 – 5:00] Close**
- Link to GitHub repo.
- Mention the commit history shows step-by-step development.

---

## 15. Future Improvements

| Priority | Improvement | Reason |
|----------|-------------|--------|
| High | Spring animation via `AnimationController` | More polished, interview-ready |
| High | Mood streak counter | Engagement mechanic |
| Medium | Weekly mood bar chart (CustomPainter) | Uses the same canvas skill, shows data viz |
| Medium | Mood note (short text per entry) | Richer data model |
| Medium | Responsive breakpoints for desktop | Better web experience |
| Low | Light/dark theme toggle | Polish |
| Low | Export mood data as CSV | Utility feature |
| Low | Firebase Firestore sync | Multi-device support |

---

*Documentation prepared for the Mood Tracker Flutter Web evaluation task.*  
*Stack: Flutter 3.x · Riverpod 2.x · Hive Flutter · intl*
