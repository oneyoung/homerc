#!/usr/bin/python3
import os
import timeit
import time


from ctypes import *



def write_file():
    f = open(path, 'wb', 0)
    #f = os.open('data.tmp', os.O_CREAT | os.O_DIRECT | os.O_TRUNC | os.O_RDWR)
    for i in range(12800):
        f.write(data)
    f.flush()
    os.fsync(f.fileno())

data = os.urandom(4096)
path = "write.temp"
#t = timeit.Timer("write_file()", "import test.py")
#print("write speed: %d", 4096*12800/t.timeit()/1024/1024)
f = open(path, 'wb', 0)
a = time.time()
#f = os.open('data.tmp', os.O_CREAT | os.O_DIRECT | os.O_TRUNC | os.O_RDWR)
for i in range(12800):
    f.write(data)
f.flush()
os.fsync(f.fileno())
b = time.time()
time_intval = b - a
print("time interval: ", time_intval)
print("write speed: ", 4096*12800/time_intval/1024/1024)
f.close()
os.remove(path)

f2 = open("test.log", "w")
f2.write("time interval: %f    " %time_intval)
write_time=4096*12800/time_intval/1024/1024
f2.write("write speed: %f " %write_time)
f2.write('\n')












data = os.urandom(4096)

FILE_ATTRIBUTE_NORMAL = c_short(0x80)
GENERIC_READ = c_uint(0x80000000)
GENERIC_ALL = c_uint(0x10000000)
NO_BUFFERING = c_uint(0x20000000)
GENERIC_WRITE = c_uint(0x40000000)
CREATE_NEW = c_uint(1)
CREATE_ALWAYS = c_uint(2)
CREATE_EXISTING = c_uint(3)

written = c_uint(0)
write = c_uint(124)

path = "temp.temp1"
path_c = cast(path, POINTER(c_char))
hFile = windll.kernel32.CreateFileW(path, GENERIC_ALL, 0, 0, CREATE_ALWAYS, NO_BUFFERING, 0)

strc = cast(data, POINTER(c_char))
#ret = windll.kernel32.WriteFile(hFile, byref(strc), sizeof(strc), byref(written), None)
a = time.time()
for i in range(12800):
    ret = windll.kernel32.WriteFile(hFile, byref(strc), 4096, byref(written), None)
b = time.time()
time_intval = b - a
print("time interval: ", time_intval)
print("write speed: ", 4096*12800/time_intval/1024/1024)
f2.write("time interval: %f    " %time_intval)
write_time=4096*12800/time_intval/1024/1024
f2.write("write speed: %f " %write_time)
f2.write('\n')

windll.kernel32.CloseHandle(hFile)



f = open(path, 'rb', 0);
#fmap = mmap.mmap(f.fileno(), 0)
#os.system(pc_cache_cmd)
#os.system(adb_cache_cmd)
a = time.time()
f.read()
b = time.time()
time_intval = b - a
print("time interval: ", time_intval)
print("read speed: ", 4096*12800/time_intval/1024/1024)
#fmap.close()
f.close()

os.remove(path)

f2.write("time interval: %f    " %time_intval)
write_time=4096*12800/time_intval/1024/1024
f2.write("read speed: %f " %write_time)
f2.write('\n')
f2.close()

