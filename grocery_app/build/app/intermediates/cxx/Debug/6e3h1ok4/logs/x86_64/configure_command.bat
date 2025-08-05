@echo off
"C:\\Users\\MSI Thin 15\\AppData\\Local\\Android\\Sdk\\cmake\\3.22.1\\bin\\cmake.exe" ^
  "-HC:\\flutter\\src\\flutter\\packages\\flutter_tools\\gradle\\src\\main\\groovy" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=21" ^
  "-DANDROID_PLATFORM=android-21" ^
  "-DANDROID_ABI=x86_64" ^
  "-DCMAKE_ANDROID_ARCH_ABI=x86_64" ^
  "-DANDROID_NDK=C:\\Users\\MSI Thin 15\\AppData\\Local\\Android\\Sdk\\ndk\\27.0.12077973" ^
  "-DCMAKE_ANDROID_NDK=C:\\Users\\MSI Thin 15\\AppData\\Local\\Android\\Sdk\\ndk\\27.0.12077973" ^
  "-DCMAKE_TOOLCHAIN_FILE=C:\\Users\\MSI Thin 15\\AppData\\Local\\Android\\Sdk\\ndk\\27.0.12077973\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=C:\\Users\\MSI Thin 15\\AppData\\Local\\Android\\Sdk\\cmake\\3.22.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=C:\\Users\\MSI Thin 15\\StudioProjects\\thesis project\\app\\online_grocery_delivery_app\\build\\app\\intermediates\\cxx\\Debug\\6e3h1ok4\\obj\\x86_64" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=C:\\Users\\MSI Thin 15\\StudioProjects\\thesis project\\app\\online_grocery_delivery_app\\build\\app\\intermediates\\cxx\\Debug\\6e3h1ok4\\obj\\x86_64" ^
  "-DCMAKE_BUILD_TYPE=Debug" ^
  "-BC:\\Users\\MSI Thin 15\\StudioProjects\\thesis project\\app\\online_grocery_delivery_app\\android\\app\\.cxx\\Debug\\6e3h1ok4\\x86_64" ^
  -GNinja ^
  -Wno-dev ^
  --no-warn-unused-cli
