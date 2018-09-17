import os, sys, time
import threading, random, queue


class ThreadRunner(threading.Thread):
    def __init__(self):
        super().__init__()
        self.__input_queue = queue.Queue(maxsize=100)
        self.__output_queue = queue.Queue(maxsize=100)
        self.__processing_lock = threading.Lock()
        self.__stop = False

    def add_input(self, item):
        self.__input_queue.put(item)

    def __get_input(self):
        try:
            return self.__input_queue.get_nowait()
        except queue.Empty:
            return None

    def __add_output(self, item):
        self.__output_queue.put(item)

    def get_output(self):
        try:
            return self.__output_queue.get_nowait()
        except queue.Empty:
            return None

    def run(self):
        while not self.__stop:
            time.sleep(0.1)
            if self.__input_queue.empty(): continue
            with self.__processing_lock:
                event = self.__get_input()
                result = self.run_event(event)
                # print("processed {} with result {}".format(event, result))
                self.__add_output((event, result))

    def stop(self):
        self.__stop = True
        self.join()

    def run_event(self, event):
        raise NotImplementedError()

    def finished(self):
        return (
            self.__input_queue.empty() and
            not self.__processing_lock.locked() and
            self.__output_queue.empty()
        )

    def wait_result(self):
        while True:
            time.sleep(0.5)
            if self.finished(): break
            # print("finished: {}".format(self.finished()))
            item = self.get_output()
            if item: yield(item)


class TestThreadRunner(ThreadRunner):
    def run_event(self, event):
        time.sleep(1 + random.random())
        kind, v = event
        if kind == 'sq':
            result = v * v
        else:
            result = 'invalid_kind'
        return result


def test():
    t = TestThreadRunner()
    t.start()
    for i in range(3):
        t.add_input(('sq', i))
    for result in t.wait_result():
        print("result: {}".format(result))
    t.stop()

if __name__=="__main__":
    test()
