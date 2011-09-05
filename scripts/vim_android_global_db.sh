#!/bin/bash - 
#===============================================================================
#
#          FILE:  vim_android_cs_db.sh
# 
#         USAGE:  ./vim_android_cs_db.sh 
# 
#   DESCRIPTION:  this script is used to generate gtags and ctags database for android project.
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: YOUR NAME (), 
#       COMPANY: 
#       CREATED: 04/14/2011 09:48:09 AM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#!/bin/bash

echo "Listing Android files ..."

find "$PWD/bionic"                                                          \
"$PWD/bootable"                                                             \
"$PWD/build"                                                                \
"$PWD/dalvik"                                                               \
"$PWD/development"                                                          \
"$PWD/device"                                                               \
"$PWD/external"                                                             \
"$PWD/frameworks"                                                           \
"$PWD/hardware"                                                             \
"$PWD/packages"                                                             \
"$PWD/system"                                                               \
"$PWD/vendor"                                                               \
-name '*.java' -print -o                                               \
-name '*.aidl' -print -o                                               \
-name '*.hpp' -print -o                                                \
-name '*.cpp'  -print -o                                               \
-name '*.xml'  -print -o                                               \
-name '*.mk'  -print -o                                                \
-name '*.[chxsS]' -print > gtags.files

echo "Listing Kernel files ..."
find  kernel                                                           \
-path "kernel/arch/*" -prune -o                                        \
-path "kernel/tmp*" -prune -o                                          \
-path "kernel/Documentation*" -prune -o                                \
-path "kernel/scripts*" -prune -o                                      \
-name "*.[chxsS]" -print >> gtags.files

find "$PWD/kernel/arch/arm/include/"                                        \
"$PWD/kernel/arch/arm/kernel/"                                              \
"$PWD/kernel/arch/arm/common/"                                              \
"$PWD/kernel/arch/arm/boot/"                                                \
"$PWD/kernel/arch/arm/lib/"                                                 \
"$PWD/kernel/arch/arm/mm/"                                                  \
"$PWD/kernel/arch/arm/mach-omap2/" -name "*.[chxsS]" -print >> gtags.files

echo "Creating gtags DB ..."
gtags 
echo "Creating ctags DB ..."
ctags -L gtags.files
echo "Creating fileNameTags DB ..."
(echo "!_TAG_FILE_SORTED	2	/2=foldcase/";
        (cat gtags.files | sort -f)) > filenametags
echo "Done"

