#!/usr/bin/env sh

#
# Copyright 2015 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Determine the Java command to use to start the JVM.
if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
        # IBM's JDK on AIX uses strange locations for the executables
        JAVACMD="$JAVA_HOME/jre/sh/java"
    else
        JAVACMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVACMD" ] ; then
        die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME

Please set the JAVA_HOME environment variable in your shell to the correct location."
    fi
else
    JAVACMD="java"
    which java >/dev/null || die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.

Please set the JAVA_HOME environment variable in your shell to the correct location or add 'java' to your PATH."
fi

# Determine the script directory.
SCRIPT_DIR="`dirname "$0"`"

# Determine the script name.
SCRIPT_NAME="`basename "$0"`"

# Determine the Gradle wrapper JAR file.
APP_BASE_NAME="gradle"
APP_NAME="$APP_BASE_NAME"
APP_HOME="$SCRIPT_DIR"
APP_BIN="$APP_HOME/bin"
APP_LIB="$APP_HOME/lib"
APP_ETC="$APP_HOME/etc"
APP_CONF="$APP_HOME/conf"
APP_OPTS_FILE="$APP_ETC/gradle.args"
APP_OPTS=""
if [ -f "$APP_OPTS_FILE" ] ; then
    APP_OPTS="`cat "$APP_OPTS_FILE"`"
fi

# Find the wrapper JAR.
WRAPPER_JAR="$APP_HOME/gradle/wrapper/gradle-wrapper-8.2.jar"
if [ ! -f "$WRAPPER_JAR" ] ; then
    die "ERROR: Could not find the Gradle wrapper JAR file: $WRAPPER_JAR"
fi

# Set Gradle properties.
GRADLE_OPTS=""
if [ -n "$GRADLE_USER_HOME" ] ; then
    GRADLE_OPTS="-Dgradle.user.home=\"$GRADLE_USER_HOME\""
fi

# Start the JVM.
exec "$JAVACMD" $JAVA_OPTS $GRADLE_OPTS -classpath "$WRAPPER_JAR" org.gradle.wrapper.GradleWrapperMain "$@"
