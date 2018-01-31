#!/bin/sh

# === OPTIONS ===
version_gradleplugin="3.0.1"
version_gradle="4.1"

version_buildtools="27.0.3"
version_minsdk="15"
version_compilesdk="26"
version_targetsdk="26"

version_appcompat="26.1.0"
version_recyclerview="26.1.0"
version_annotations="26.1.0"
version_preference="26.1.0"
version_design="26.1.0"

version_constraintlayout="1.0.2"

version_testrunner="1.0.1"
version_testrules="1.0.1"
#version_junit="4.12"

mainpath="*/*"


# Some templates.
num="[0-9]\+"
optdot="\(\.$num\)\?"
optrc="\(\-rc$num\)\?"
optbeta="\(\-beta$num\)\?"
vers="$num\(\.$num\)*$optrc$optbeta"

apppath="$mainpath/app"


# ==== MAIN GRADLE FILE ====

# Update gradle plugin version fro Android Studio 3.
prefix="com\.android\.tools\.build\:gradle\:"
sub="$vers"
find $mainpath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$version_gradleplugin/g" {} \;

# Update gradle wrapper.
sub="gradle\-$vers\-"
goal="gradle-$version_gradle-"
find $mainpath/gradle/wrapper/gradle-wrapper.properties -exec sed -i "s/$sub/$goal/g" {} \;

# Remove build directory change.
#sub="\n.*String osName =.*\n.*\n.*\n.*}.*\n"
#goal="\n"
#find $mainpath/build.gradle -exec perl -0777 -pi -e "s/$sub/$goal/g" {} \;

# Change build directory location.
#sub="C\:\/tmp\/"
#goal="E:\/DENIS\/Projects\/Android\/GoogleChallenge\/_build\/"
#find $mainpath/build.gradle -exec sed -i "s/$sub/$goal/g" {} \;

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
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$version_compilesdk/g" {} \;

# Set build tools version.
prefix="buildToolsVersion "
sub="\s*[\"\']$vers[\"\']"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix\"$version_buildtools\"/g" {} \;

# Set minimal SDK version.
prefix="minSdkVersion "
sub="\s*$num"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$version_minsdk/g" {} \;

# Set target SDK version.
prefix="targetSdkVersion "
sub="\s*$num"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$version_targetsdk/g" {} \;

# Update appcompat library version.
prefix="com\.android\.support\:appcompat\-v7\:"
sub="$vers"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$version_appcompat/g" {} \;

# Update support-annotations library version.
prefix="com\.android\.support\:support\-annotations\:"
sub="$vers"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$version_annotations/g" {} \;

# Update test:runner library version.
prefix="com\.android\.support\.test\:runner\:"
sub="$vers"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$version_testrunner/g" {} \;

# Update test:rules library version.
prefix="com\.android\.support\.test\:rules\:"
sub="$vers"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$version_testrules/g" {} \;

# Update junit library version.
#prefix="junit\:junit\:"
#sub="$vers"
#find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$version_junit/g" {} \;

# Update constraints layout library version.
prefix="com\.android\.support\.constraint\:constraint\-layout\:"
sub="$vers"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$version_constraintlayout/g" {} \;

# Update design library version.
prefix="com\.android\.support\:design\:"
sub="$vers"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$version_design/g" {} \;

# Update recycler view library version.
prefix="com\.android\.support\:recyclerview\-v7\:"
sub="$vers"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$version_recyclerview/g" {} \;

# Update preference library version.
prefix="com\.android\.support\:preference\-v7\:"
sub="$vers"
find $apppath/build.gradle -exec sed -i "s/$prefix$sub/$prefix$version_preference/g" {} \;

# Remove backup file.
find $apppath/build.gradle.bak -exec rm -f {} \;
