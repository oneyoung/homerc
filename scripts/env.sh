#!/bin/bash
sdk_path=~/android/android-sdk-linux_x86/tools
java_path=~/android/toolchain/jdk1.5.0_22/bin/
complier_path=/home/oneyoung/android/toolchain/toolchain-eabi-4.4.0/bin/
export PATH=$PATH:$sdk_path:$complier_path:$java_path
export TARGET_TOOLS_PATH=$complier_path 

