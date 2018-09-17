import os, sys
import time, threading, random
 
def run(name):
    waits = 3
    for i in range(waits):
        print("{}: wait for {}/{}".format(name, i+1, waits))
        time.sleep(random.random() / 10.0)
    print("{}: finished".format(name))

def async_run():
    threads = []
    for i in range(3):
        t = threading.Thread(target=run, args = ("thread{}".format(i+1), ))
        threads.append(t)

    [t.start() for t in threads]
    [t.join() for t in threads]

def ignore_run():
    ignore_thread_run_function(run, "ignore1")
    ignore_thread_run_function(run, "ignore2")
    print("waiting")
    print("threads: {}\n".format(len(IGNORE_THREADS)))

    time.sleep(2)
    print("threads: {}\n".format(len(IGNORE_THREADS)))
    ignore_thread_run_function(run, "ignore3")
    print("waiting")

    time.sleep(2)
    print("threads: {}\n".format(len(IGNORE_THREADS)))
    print("finished")

IGNORE_THREADS = []

def ignore_thread_run_function(func, *args):
    # join previous finished threads
    for i in reversed(range(len(IGNORE_THREADS))):
        t = IGNORE_THREADS[i]
        if not t.is_alive():
            t.join()
            IGNORE_THREADS.pop(i)

    t = threading.Thread(target=func, args = args)
    IGNORE_THREADS.append(t)
    t.start()

if __name__=="__main__":
    # run('sync1')
    # async_run()
    ignore_run()

