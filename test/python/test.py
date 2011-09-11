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
