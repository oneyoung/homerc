#!/bin/bash - 
#===============================================================================
#
#          FILE:  ls.sh
# 
#         USAGE:  ./ls.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: YOUR NAME (), 
#       COMPANY: 
#       CREATED: 2010年12月02日 15时01分24秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

file=/tmp/$$.tmp
ls $@ > $file
cat $file |\
	awk '{print NR,"\t", $0}'
echo -n "Enter your choice(number):"
read choice
filename=`sed -n "$choice p" $file|awk '{print $NF}'`
echo -n $filename | xclip -i -selection clipboard
rm $file
