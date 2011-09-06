#!/bin/bash
script_path=~/scripts

find . -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.S" -o -name "*.mk" -o -name Makefile -o -name "*.lds" -o -name "*.inc" -o -name "*.make" > cscope.file
cscope -bkq -i cscope.file
#rm cscope.file
ctags -R

#script_path -- the path contains vim_fntags.sh 
#NOTE it is a global varibles which export by .bashrc
${script_path}/vim_fntags.sh
