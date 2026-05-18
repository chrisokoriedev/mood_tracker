#!/usr/bin/env bash
set -euo pipefail

FLUTTER_HOME="${FLUTTER_HOME:-/tmp/flutter-sdk}"

if [ ! -x "$FLUTTER_HOME/bin/flutter" ]; then
  git clone --depth 1 --filter=blob:none --branch stable https://github.com/flutter/flutter.git "$FLUTTER_HOME"
fi

export PATH="$FLUTTER_HOME/bin:$PATH"

flutter config --no-analytics
flutter pub get