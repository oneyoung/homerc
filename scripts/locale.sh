#!/bin/bash - 
#===============================================================================
#
#          FILE:  locale.sh
# 
#         USAGE:  ./locale.sh 
# 
#   DESCRIPTION:  to export local to ZH_CN
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: YOUR NAME (), 
#       COMPANY: 
#       CREATED: 04/01/2011 02:06:34 PM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:zh
export LC_CTYPE="zh_CN.UTF-8"
export LC_NUMERIC="zh_CN.UTF-8"
export LC_TIME="zh_CN.UTF-8"
export LC_COLLATE="zh_CN.UTF-8"
export LC_MONETARY="zh_CN.UTF-8"
export LC_MESSAGES="zh_CN.UTF-8"
export LC_PAPER="zh_CN.UTF-8"
export LC_NAME="zh_CN.UTF-8"
export LC_ADDRESS="zh_CN.UTF-8"
export LC_TELEPHONE="zh_CN.UTF-8"
export LC_MEASUREMENT="zh_CN.UTF-8"
export LC_IDENTIFICATION="zh_CN.UTF-8"
export LC_ALL="zh_CN.UTF-8"

gedit $@
