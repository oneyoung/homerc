#!/bin/bash - 
#===============================================================================
#
#          FILE:  vim_fntags.sh
# 
#         USAGE:  ./vim_fntags.sh 
# 
#   DESCRIPTION:  a script to generite filenametags for vim plugin -- lookupfiles
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: YOUR NAME (), 
#       COMPANY: 
#       CREATED: 02/28/2011 04:55:50 PM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
filetags=./filenametags

#echo "!_TAG_FILE_SORTED          2       /2=foldcase/" >$filetags
#find . -not -iname ".*" -type f -printf "%f\t%p\t1\n" | sort >>$filetags

(echo "!_TAG_FILE_SORTED	2	/2=foldcase/";
(find . -not -name ".*" -type f -printf "%f\t%p\t1\n" | \
         sort -f)) > ./$filetags 
