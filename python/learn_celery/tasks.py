from celery import Celery

app = Celery('tasks', broker='redis://localhost//', backend='rpc://')

@app.task
def add(x, y):
    return x + y
