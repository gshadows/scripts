#!/bin/sh

# Some templates.
num="[0-9]\+"
optdot="\(\.$num\)\?"
optrc="\(\-rc$num\)\?"
optbeta="\(\-beta$num\)\?"
vers="$num\(\.$num\)*$optrc$optbeta"

mainpath="*/*"
apppath="$mainpath/app"


# ==== MAIN GRADLE FILE ====

# Update gradle plugin version fro Android Studio 3.
prefix="com\.android\.tools\.build\:gradle\:"
sub="$vers"
goal="3.0.0-rc2"
find $mainpath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Update gradle wrapper.
sub="gradle\-$vers\-"
goal="gradle-4.1-"
find $mainpath/gradle/wrapper/gradle-wrapper.properties -exec sed -i "s/$sub/$goal/g" {} \;

# Remove build directory change.
#sub="\n.*String osName =.*\n.*\n.*\n.*}.*\n"
#goal="\n"
#find $mainpath/build.gradle -exec perl -0777 -pi -e "s/$sub/$goal/g" {} \;

# Change build directory location.
sub="C\:\/tmp\/"
goal="E:\/DENIS\/Projects\/Android\/GoogleChallenge\/_build\/"
find $mainpath/build.gradle -exec sed -i "s/$sub/$goal/g" {} \;

# Add Google repository.
sub="jcenter\(\)"
goal="google()\n        jcenter()"
find $mainpath/build.gradle -exec perl -0777 -pi -e "s/$sub/$goal/g" {} \;

# Remove duplicate Google repository.
sub="google\(\)\n        google\(\)"
goal="google()"
find $mainpath/build.gradle -exec perl -0777 -pi -e "s/$sub/$goal/g" {} \;

# Remove backup file.
find $mainpath/build.gradle.bak -exec rm -f {} \;

# ==== APPLICATION GRADLE FILE ====

# Set compile SDK version.
prefix="compileSdkVersion "
sub="\s*$num"
goal="26"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Set build tools version.
prefix="buildToolsVersion "
sub="\s*[\"\']$vers[\"\']"
goal="\"27.0.0\""
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Set minimal SDK version.
prefix="minSdkVersion "
sub="\s*$num"
goal="15"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Set target SDK version.
prefix="targetSdkVersion "
sub="\s*$num"
goal="26"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Update appcompat library version.
prefix="com\.android\.support\:appcompat\-v7\:"
sub="$vers"
goal="26.1.0"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Update support-annotations library version.
prefix="com\.android\.support\:support\-annotations\:"
sub="$vers"
goal="26.1.0"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Update test:runner library version.
prefix="com\.android\.support\.test\:runner\:"
sub="$vers"
goal="1.0.1"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Update test:rules library version.
prefix="com\.android\.support\.test\:rules\:"
sub="$vers"
goal="1.0.1"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Update constraints layout library version.
prefix="com\.android\.support\.constraint\:constraint\-layout\:"
sub="$vers"
goal="1.1.0-beta3"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$goal/g" {} \;

# Remove backup file.
find $apppath/build.gradle.bak -exec rm -f {} \;
