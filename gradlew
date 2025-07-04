#!/usr/bin/env sh
# Simple Gradle wrapper script for GitHub Actions

# Determine the script directory.
# This ensures the script can find the wrapper JAR relative to its own location.
SCRIPT_DIR="$(dirname "$0")"

# Path to the Gradle wrapper JAR.
# It's expected to be in the 'gradle/wrapper/' subdirectory relative to gradlew.
WRAPPER_JAR="$SCRIPT_DIR/gradle/wrapper/gradle-wrapper.jar"

# Check if the wrapper JAR exists.
# If not, print an error and exit.
if [ ! -f "$WRAPPER_JAR" ]; then
  echo "Error: Gradle wrapper JAR not found at $WRAPPER_JAR"
  exit 1
fi

# Execute the Gradle wrapper JAR using Java.
# "$@" passes all command-line arguments (like "assembleDebug") to the JAR.
exec java -jar "$WRAPPER_JAR" "$@"
