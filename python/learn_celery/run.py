from tasks import add

result = add.delay(4, 4)
result.ready() == False
result.get(timeout=1) == 8

result.get(propagate=False)
result.traceback

