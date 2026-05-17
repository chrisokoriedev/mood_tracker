import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final animationNotifierProvider = NotifierProvider<AnimationNotifier, String?>(
  AnimationNotifier.new,
);

class AnimationNotifier extends Notifier<String?> {
  Timer? _timer;
  @override
  String? build() {
    ref.onDispose(() => _timer?.cancel());
    return null;
  }

  void triggerAnimation(String entryId) {
    _timer?.cancel();
    if (state == entryId) {
      state = null;
    } else {
      state = entryId;
      _timer = Timer(const Duration(milliseconds: 800), () {
        state = null;
      });
    }
  }
}
