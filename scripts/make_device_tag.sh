#!/bin/bash - 
#===============================================================================
#
#          FILE:  make_device_tag.sh
# 
#         USAGE:  ./make_device_tag.sh 
# 
#   DESCRIPTION:  a script to make tags database from android devices
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: YOUR NAME (), 
#       COMPANY: 
#       CREATED: 05/16/2011 04:38:30 PM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

flist_before=flist_before
flist_after=flist_after
flist_temp=flist_temp
timestamp=timestamp
flist=gtags.files

#get file list before make
find -type f | sort > ${flist_before}

#make a timestamp
#if [ -e "${timestamp}" ]
#        then
#                rm ${timestamp}
#fi
touch ${timestamp}

#---past your device make cmd here---------


#-------------------------------------------

#find out which file is accessed
find -type f -anewer ${timestamp} | sort > ${flist_after}
comm -12 ${flist_before} ${flist_after} > ${flist_temp}

#get the file we need.
grep "\.java$\|\.aidl$\|\.hpp$\|\.cpp$\|\.xml$\|\.mk$\|\.[chxsS]$" ${flist_temp} > ${flist}

rm ${flist_before} ${flist_after} ${timestamp}
