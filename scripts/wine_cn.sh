#!/bin/bash - 
#===============================================================================
#
#          FILE:  wine_cn.sh
# 
#         USAGE:  ./wine_cn.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: YOUR NAME (), 
#       COMPANY: 
#       CREATED: 04/01/2011 02:30:25 PM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

function create_wine_script()
{
        echo '#!/bin/bash

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

        /usr/bin/wine-run $@' > $1
}

file /usr/bin/wine | grep ELF 1>/dev/null
if [ $? -eq 0 ]
        then
                cp /usr/bin/wine /usr/bin/wine-run
                rm /usr/bin/wine
                touch /usr/bin/wine
                chmod a+x /usr/bin/wine
                create_wine_script  /usr/bin/wine
fi

