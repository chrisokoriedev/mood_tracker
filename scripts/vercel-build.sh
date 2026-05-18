#!/usr/bin/env bash
set -euo pipefail

FLUTTER_HOME="${FLUTTER_HOME:-/tmp/flutter-sdk}"

export PATH="$FLUTTER_HOME/bin:$PATH"

flutter build web --release