# pip install events
# https://events.readthedocs.io/en/latest/
from events import Events

def test1():
    def something_changed(reason):
        print("something changed because (%s)" % reason)
    events = Events()
    events.on_change += something_changed
    events.on_change('it had to happen')

    for event in events:
        print("event name: {}".format(event.__name__))
        for handler in event:
            print("handler name: {}".format(handler.__name__))

    events.on_change.targets.pop()
    events.on_change('it should not to be happen')


class Item():
    def __init__(self, name):
        self.name = name

    def display_data(self, data):
        print("display: {}".format(data))
        

def test2():
    p = Item("parent")
    c = Item("child")
    p.on_change += c.display_data
    p.on_change(12)

def main():
    test1()

if __name__=="__main__":
    main()
