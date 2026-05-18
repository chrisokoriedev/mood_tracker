# 🎙️ Mood Tracker App Demo & Code Walkthrough
> **Target Duration:** < 5 Minutes  
> **Key Goal:** Showcase a premium, responsive Flutter Web Mood Tracker with advanced Riverpod state management and CustomPainter faces.

---

## ⏱️ Video Timeline Overview
| Segment | Duration | Focus Area | Key Files & Widgets |
| :--- | :--- | :--- | :--- |
| **1. Live App Demo** | `00:00 - 01:30` | Visuals, logging moods, timeline animations | [home.dart](file:///c:/Users/chrisokoriedev/Documents/work/test/mood_tracker/lib/features/home.dart) <br> [time_line.dart](file:///c:/Users/chrisokoriedev/Documents/work/test/mood_tracker/lib/util/widgets/time_line.dart) |
| **2. State Management** | `01:30 - 03:00` | Riverpod notifiers, local Hive persistence, animation states | [mood_notifier.dart](file:///c:/Users/chrisokoriedev/Documents/work/test/mood_tracker/lib/core/providers/mood_notifier.dart) <br> [animation_notifier.dart](file:///c:/Users/chrisokoriedev/Documents/work/test/mood_tracker/lib/core/providers/animation_notifier.dart) |
| **3. CustomPainter Faces** | `03:00 - 04:15` | Rendering dynamic vector expressions mathematically | [mood_face_painter.dart](file:///c:/Users/chrisokoriedev/Documents/work/test/mood_tracker/lib/util/painters/mood_face_painter.dart) |
| **4. Future Upgrades**| `04:15 - 05:00` | Continuous improvement, trend analysis, cloud integration | n/a |

---

## 🎬 Section 1: Live Application Demo (`00:00 - 01:30`)

### 📺 Visual Action:
* Start with the Flutter Web app running in a browser window.
* Show the clean, mobile-frame wrapper (centered layout on large web widths).
* Point out the beautiful aesthetic: the background color is a subtle gradient matching the current mood, with a premium glassmorphic bottom sheet panel.

### 🗣️ Voiceover Script:
> *"Hey everyone! Welcome to this quick walkthrough of our brand new Mood Tracker application. Built with Flutter, this web app aims to offer an extremely clean, visual, and premium journaling experience.*
>
> *First, let's take a look at the design. The entire background is wrapped in a dynamic `AnimatedContainer` that transitions its gradient and theme colors to match your dominant mood. At the bottom, we have a glassmorphic bottom sheet hosting our timeline of entries.*
>
> *Let's log a couple of moods. Right now, our active mood is neutral. Let's say I'm feeling **Excited** today. I simply tap the Excited icon on our selector. Notice how the background gradient morphs instantly into a warm, positive orange hue, and the large vector avatar displays a playful star-eyed expression with a supportive message.*
>
> *Now, let's say a few hours later I'm feeling a bit **Anxious**. Let's log that mood. Tap—the UI adapts immediately to a cool, calming blue-violet tone with a wavy-mouth face and a soothing deep-breathing reminder.*
>
> *Look at the scrolling timeline below. Every entry is fully preserved in our ledger. If I want to highlight or review a past entry, I can tap on any card in the timeline—like this Sad entry or this Excited entry. Tapping triggers a micro-animation that scales the card by `1.04` and gives it a subtle dynamic tilt, making the interaction feel tactile and highly interactive!"*

---

## 💻 Section 2: State Management with Riverpod & Hive (`01:30 - 03:00`)

### 📺 Visual Action:
* Switch your IDE to `lib/core/providers/mood_notifier.dart` and `lib/core/providers/animation_notifier.dart`.
* Highlight the `MoodNotifier` and `AnimationNotifier` class structures.

### 🗣️ Voiceover Script:
> *"Now let's dive under the hood to see how this fluid interaction is achieved. We utilize **Riverpod** for highly predictable, modular state management coupled with **Hive** for ultra-fast local persistence.*
>
> *First, let's look at [mood_notifier.dart](file:///c:/Users/chrisokoriedev/Documents/work/test/mood_tracker/lib/core/providers/mood_notifier.dart). Our `MoodNotifier` extends Riverpod's `Notifier<List<MoodEntry>>`. In the `build()` method, we initialize our Hive box and pull recorded moods, sorting them chronologically to show the 7 latest entries on the dashboard. When a user logs a mood, the `addEntry` function creates a new `MoodEntry` with a timestamped ID, persists it in Hive, and updates our notifier's state, instantly triggering clean UI rebuilds.*
>
> *Second, how does the timeline tap animation work? Let's open [animation_notifier.dart](file:///c:/Users/chrisokoriedev/Documents/work/test/mood_tracker/lib/core/providers/animation_notifier.dart). Here, we have an `AnimationNotifier` which manages a simple `String?` representing the active animating entry's ID. When `triggerAnimation(entryId)` is called, it registers the ID as the active animating state. A built-in 800ms `Timer` automatically clears the ID back to `null` to reset the card. Let's look at [time_line.dart](file:///c:/Users/chrisokoriedev/Documents/work/test/mood_tracker/lib/util/widgets/time_line.dart)—it watches this provider, and dynamically updates its `AnimatedContainer` transform with a scale and rotation whenever its own `entryId` matches the active animating ID!"*

---

## 🎨 Section 3: CustomPainter Expressions (`03:00 - 04:15`)

### 📺 Visual Action:
* Switch your IDE to [mood_face_painter.dart](file:///c:/Users/chrisokoriedev/Documents/work/test/mood_tracker/lib/util/painters/mood_face_painter.dart).
* Focus on `void paint(...)` and specifically highlight the `_drawExcited(...)` or `_drawAnxious(...)` methods.

### 🗣️ Voiceover Script:
> *"What makes our mood tracker unique is that we don't rely on static images or heavy SVG assets. Every single face is drawn programmatically on-the-fly using a custom-built [MoodFacePainter](file:///c:/Users/chrisokoriedev/Documents/work/test/mood_tracker/lib/util/painters/mood_face_painter.dart) extending `CustomPainter`.*
>
> *In our `paint` method, we set up our primary paint brushes: `fillPaint` to give a subtle color glow, and `strokePaint` to draw precise, thick, round lines. We draw the main face shape using `canvas.drawCircle(center, radius, paint)`. From there, we switch on the `MoodType` enum to draw distinct features.*
>
> *For instance, let's look at how we draw the **Anxious** face. In `_drawAnxious`, we draw two circles for the eyes. To draw the uneasy, wavy mouth expression, we construct a vector `Path` and use two consecutive `quadraticBezierTo` calls, blending control points to create a perfect sinus wave. *
>
> *For our **Excited** face, instead of standard eyes, we draw five-point stars. We achieve this mathematically in `_drawStarEye` by looping through 10 points on a circle, alternating between an outer radius and an inner radius using trigonometry (`math.cos` and `math.sin` relative to the eye center) to generate the star vector outline.*
>
> *This programmatic approach keeps our app lightweight, crisp at any screen resolution, and extremely responsive to color transitions."*

---

## 🚀 Section 4: Future Improvements (`04:15 - 05:00`)

### 📺 Visual Action:
* Switch your IDE back to the active app demo running in the browser. 
* Hover over the bottom sheet or scroll the timeline cards.

### 🗣️ Voiceover Script:
> *"While the core app is robust and visually striking, there are a few features we are excited to introduce in the next sprint:*
>
> 1. * **Mood Trend Charts:** We plan to integrate a weekly and monthly line chart using `fl_chart` to visualize how your emotional state changes over time.*
> 2. * **Advanced Micro-Interactions:** Currently, we morph colors instantly when a mood is selected. We want to implement a custom `AnimationController` that morphs the CustomPainter lines between states smoothly (e.g., watching a sad mouth curve slowly upward into a happy smile).*
> 3. * **Cloud Synchronization:** Moving from a pure local Hive box to a secure cloud backend like Supabase or Firebase, enabling users to sync their emotional journal securely across mobile, desktop, and web.*
>
> *Thank you so much for joining me today. I hope this walkthrough has shown how Riverpod, Hive, and CustomPainter can come together to make a premium, responsive Flutter app. Let me know your thoughts!"*
