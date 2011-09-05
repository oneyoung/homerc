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


source_file=/tmp/source.list
include_file=/tmp/include.list
output_file=cscope.files
source_file_temp=/tmp/source_file_temp
output_file_temp=/tmp/output.temp

if ! [ -f "$output_file" ]
then
        generate_flag=1
        #echo run if
        echo "INFO: $output_file does NOT exits."
        echo "INFO: clean the kernel"
        make clean
        echo "INFO: make kernel, it may take a few minutes, please wait"
        make ARCH=arm CROSS_COMPILE=arm-eabi- CFLAGS_KERNEL=-H -j4 1>$source_file 2>$include_file
        if [ $? -ne 0 ]
                then
                echo -e "\033[31mERR: ########make process failed! #############\033[0m" #highlight the error message in red 
                echo "TIP: may be you need to make defconfig first"
                exit
        fi

        #for test
        #source_file=source.list
        #include_file=include.list
        #output_file=cscope.files
        #source_file_temp=/tmp/source_file_temp

        echo "INFO: get the file list"
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
        rm cscope.*out* 2>/dev/null
fi

if [ $generate_flag ]
then
        echo "INFO: generate the database"
else
        echo "INFO: update the datebase"
fi
cscope -bkq -i $output_file  
ctags -L $output_file

#script_path -- the path contains vim_fntags.sh 
#NOTE it is a global varibles which export by .bashrc
vim_fntags.sh

echo "INFO: All DONE!"
