#!/usr/bin/env python
import os


db = 'cscope.file'

if not os.path.exists(db):
    os.system('''find . -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.S" -o -name "*.mk" -o -name Makefile -o -name "*.lds" -o -name "*.inc" -o -name "*.make" -o -name "*.java" >  %s ''' % db)

os.system("ctags -L %s" % db)
os.system("cscope -bkq -i %s" % db)
