#!/bin/bash - 
#===============================================================================
#
#          FILE:  git_pull_local.sh
# 
#         USAGE:  ./git_pull_local.sh 
# 
#   DESCRIPTION:  a script to git pull from local repo
#               1. first repo sync the local repo
#               2. pull the code from local repo
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: YOUR NAME (), 
#       COMPANY: 
#       CREATED: 05/03/2011 01:49:56 PM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

local_repo_dir=/home/oneyoung/android/repo
target_git=

#check if git is inited
if [ -d .git ]
then
        echo
else
        git init
fi

echo "-----------repo ${target_git}.git from server--------------"
cd ${local_repo_dir}
repo sync ${target_git}

echo "---------- git pull the code from local repo---------------"
cd -
git pull ${local_repo_dir}/${target_git}/.git

if [ -e GTAGS ]
        then
                echo "---------------updating gtags database -----------------"
                global -u
fi
