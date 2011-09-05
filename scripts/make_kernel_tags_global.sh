#!/bin/bash - 
#===============================================================================
#
#          FILE:  make_kernel_tags.sh
# 
#         USAGE:  ./make_kernel_tags.sh 
# 
#   DESCRIPTION:  a script using kernel Makefile to generate file list
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: YOUR NAME (), 
#       COMPANY: 
#       CREATED: 02/25/2011 09:18:01 AM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

source_file=/tmp/source.list
include_file=/tmp/include.list
output_file=gtags.files
source_file_temp=/tmp/source_file_temp
output_file_temp=/tmp/output.temp
make clean
make ARCH=arm CROSS_COMPILE=arm-eabi- CFLAGS_KERNEL=-H -j8 1>$source_file 2>$include_file

#for test
#source_file=source.list
#include_file=include.list
#output_file=gtags.files
#source_file_temp=/tmp/source_file_temp

# generate the include file
grep "^\.\+\ " $include_file | awk '{print $NF}' | sort -u >$output_file

# generate the source file
grep "\(\<CC\>\|\<AS\>\|LOGO\)" $source_file | awk '{print $NF}' >$source_file_temp
for i in $(cat $source_file_temp)
        do
                cc_source=${i%.o}.c
                as_source=${i%.o}.S
                if [ -f $cc_source ]; then
                        echo $cc_source >>$output_file
                        else
                        if [ -f $as_source ]; then
                                echo $as_source >>$output_file
                        fi
                fi
        done

mv $output_file $output_file_temp 
for i in $(cat $output_file_temp)
        do
                if [ -f $i ]; then
                        echo $i >>$output_file
                fi
        done

rm $output_file_temp $source_file_temp $source_file $include_file
#rm gtags.*out*
gtags -f $output_file  
ctags -L $output_file


#script_path -- the path contains vim_fntags.sh 
#NOTE it is a global varibles which export by .bashrc
${script_path}/vim_fntags.sh
