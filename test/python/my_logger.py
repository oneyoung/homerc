#!/usr/bin/python3

import sys
class logger:
    def __init__(self, f_name):
        self.f = open(f_name, 'a')
        sys.stdout = self

    def write(self, s):
        self.f.write(s)
        sys.__stdout__.write(s)
        pass

    def __exit___(self):
        sys.stdout = self.stdout_
        self.f.close()
