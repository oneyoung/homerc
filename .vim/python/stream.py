import vim
import subprocess
from threading import Thread as thread
import atexit

def output_lines_to_buffer(cmd):
    """
    Append the given shell command's output linewise to the current buffer.
    """
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
    @atexit.register
    def exit_handler():
        #if the cmd is not exit yet when vim exit, terminate it
        if p.poll() is None:
            p.terminate()

    vim_add = vim.current.buffer.append
    vim_cmd = vim.command
    for line in iter(p.stdout.readline, ''):
        vim_add(line)
        vim_cmd('redraw')

def run(cmd):
    th = thread(target = output_lines_to_buffer, args = ([cmd]))
    th.daemon = True
    th.start()
