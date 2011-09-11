#!/usr/bin/python3
import os
import timeit
import time
def write_file():
    f = open("data.tmp", 'wb', 0)
    for i in range(12800):
        f.write(data)
    f.flush()
    os.fsync(f.fileno())
    f.close()

data = os.urandom(4096)
#t = timeit.Timer("write_file()", "import test.py")
#print("write speed: %d", 4096*12800/t.timeit()/1024/1024)

a = time.time()
write_file()
b = time.time()
time_intval = b - a
print("time interval: ", time_intval)
print("write speed: ", 4096*12800/time_intval/1024/1024)

pc_cache_cmd = "/sbin/sysctl vm.drop_caches=3 > /dev/null"
adb_cache_cmd = "adb shell 'echo 3 > /proc/sys/vm/drop_caches'"
import mmap
f = open("data.tmp", 'rb', 0);
fmap = mmap.mmap(f.fileno(), 0, prot=mmap.PROT_READ)
os.system(pc_cache_cmd)
os.system(adb_cache_cmd)
a = time.time()
fmap.read(4096*128000)
b = time.time()
time_intval = b - a
print("time interval: ", time_intval)
print("read speed: ", 4096*12800/time_intval/1024/1024)
fmap.close()


os.remove("data.tmp")

from ctypes import *

data = "123456"

FILE_ATTRIBUTE_NORMAL = c_short(0x80)
GENERIC_READ = c_uint(0x80000000)
NO_BUFFERING = c_uint(0x20000000)
GENERIC_WRITE = c_uint(0x40000000)
CREATE_NEW = c_uint(1)
CREATE_ALWAYS = c_uint(2)
CREATE_EXISTING = c_uint(3)

written = c_uint(0)

path = 'C:\\temp.temp'
path_c = cast(path, POINTER(c_char))
hFile = windll.kernel32.CreateFileA(path_c, GENERIC_WRITE, 0, 0, CREATE_ALWAYS, NO_BUFFERING, 0)

strc = cast(data, POINTER(c_char))
ret = windll.kernel32.WriteFile(hFile, strc, sizeof(strc), byref(written), None)
