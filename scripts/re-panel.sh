#!/bin/bash - 
#===============================================================================
#
#          FILE:  re-panel.sh
# 
#         USAGE:  ./re-panel.sh 
# 
#   DESCRIPTION: a script to restore ubuntu panel to default  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: YOUR NAME (), 
#       COMPANY: 
#       CREATED: 12/17/2010 09:16:59 AM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

gconftool --recursive-unset /apps/panel
rm -rf ~/.gconf/apps/panel
pkill gnome-panel
