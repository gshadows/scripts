#!/bin/sh

# === OPTIONS ===
version_gradleplugin="3.1.2"
version_gradle="4.4"

version_buildtools="28.0.0"
version_minsdk="15"
version_compilesdk="28"
version_targetsdk="28"

version_appcompat="27.1.1"
version_recyclerview="27.1.1"
version_annotations="27.1.1"
version_preference="27.1.1"
version_design="27.1.1"

version_constraintlayout="1.1.1"

version_testrunner="1.0.1"
version_testrules="1.0.1"
#version_junit="4.12"

mainpath="*"


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

# Change deprecated "compile" to "implementation".
sub="$vers"
find $apppath/build.gradle -exec sed -i "s/compile\ /implementation\ /g" {} \;
find $apppath/build.gradle -exec sed -i "s/testCompile/testImplementation/g" {} \;
find $apppath/build.gradle -exec sed -i "s/androidTestCompile/androidTestImplementation/g" {} \;

# Remove backup file.
find $apppath/build.gradle.bak -exec rm -f {} \;
