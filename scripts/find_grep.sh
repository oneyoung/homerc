#!/bin/bash

find -name '*.java' -o \
	-name '*.aidl' -o \
	-name '*.hpp' -o \
	-name '*.cpp' -o \
	-name '*.xml' -o \
	-name '*.mk' -o \
	-name '*.[chxsS]'  -exec grep -nH "$1" {} \;

