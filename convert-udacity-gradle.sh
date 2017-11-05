#!/bin/sh

# Some templates.
num="[0-9]\+"
dots3="$num\.$num\.$num"
optrc="\(-rc[0-9]\+\)\?"


# ==== MAIN GRADLE FILE ====

# Update gradle plugin version fro Android Studio 3.
prefix="com\.android\.tools\.build\:gradle\:"
sub="$dots3$optrc"
goal="3.0.0-rc2"
find */*/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Remove build directory change.
#sub="\n.*String osName =.*\n.*\n.*\n.*}.*\n"
#goal="\n"
#find */*/build.gradle -exec perl -0777 -pi -e "s/$sub/$goal/g" {} \;

# Add Google repository.
sub="jcenter\(\)"
goal="google()\n        jcenter()"
find */*/build.gradle -exec perl -0777 -pi -e "s/$sub/$goal/g" {} \;

# Remove backup file.
find */*/build.gradle.bak -exec rm -f {} \;

# ==== APPLICATION GRADLE FILE ====

# Set compile SDK version.
prefix="compileSdkVersion "
sub="\s*$num"
goal="26"
find */*/app/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Set build tools version.
prefix="buildToolsVersion "
sub="\s*[\"\']$dots3[\"\']"
goal="\"27.0.0\""
find */*/app/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Set minimal SDK version.
prefix="minSdkVersion "
sub="\s*$num"
goal="15"
find */*/app/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Set target SDK version.
prefix="targetSdkVersion "
sub="\s*$num"
goal="26"
find */*/app/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Update gradle plugin version fro Android Studio 3.
prefix="com\.android\.support\:appcompat\-v7\:"
sub="$dots3$optrc"
goal="26.1.0"
find */*/app/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;
