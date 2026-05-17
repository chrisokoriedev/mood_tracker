import 'package:flutter_riverpod/flutter_riverpod.dart';

final animationNotifierProvider = NotifierProvider<AnimationNotifier, String?>(
  AnimationNotifier.new,
);

class AnimationNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  void triggerAnimation(String entryId) {
   
  }
}
